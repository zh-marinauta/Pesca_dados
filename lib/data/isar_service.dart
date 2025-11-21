import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:marinuata_app/data/landing_model.dart';
import 'package:marinuata_app/data/reference_models.dart';
import 'package:marinuata_app/data/initial_data.dart';

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      final isar = await Isar.open(
        [LandingSchema, SpeciesSchema, ProductiveUnitSchema, FishingGearSchema],
        directory: dir.path,
        inspector: true,
      );

      if (await isar.species.count() == 0) {
        await isar.writeTxn(() async {
          for (var name in InitialData.species) {
            await isar.species.put(Species()
              ..name = name
              ..defaultUnit = 'kg');
          }
        });
      }
      if (await isar.fishingGears.count() == 0) {
        await isar.writeTxn(() async {
          for (var name in InitialData.fishingGears) {
            await isar.fishingGears.put(FishingGear()..name = name);
          }
        });
      }
      return isar;
    }
    return Future.value(Isar.getInstance());
  }

  // --- 1. SALVAR COM INTELIGÊNCIA REFINADA (V1.2) ---
  Future<void> saveLandingWithLearning(Landing landing) async {
    final isar = await db;

    await isar.writeTxn(() async {
      // A. Salva a Coleta
      await isar.landings.put(landing);

      // B. INTELIGÊNCIA DE UNIDADE PRODUTIVA
      final pName = landing.fishermanName?.trim();
      final bName = landing.boatName?.trim();
      final comm = landing.community?.trim();

      if ((pName != null && pName.isNotEmpty) ||
          (bName != null && bName.isNotEmpty)) {
        ProductiveUnit? targetUnit;

        final candidates = await isar.productiveUnits
            .filter()
            .group((q) => q
                .fishermanNameEqualTo(pName ?? '', caseSensitive: false)
                .or()
                .boatNameEqualTo(bName ?? '', caseSensitive: false))
            .findAll();

        // Nível A: MATCH EXATO
        try {
          targetUnit = candidates.firstWhere((u) {
            return _compare(u.fishermanName, pName) &&
                _compare(u.boatName, bName) &&
                _compare(u.community, comm);
          });
        } catch (e) {
          targetUnit = null;
        }

        // Nível B: ENRIQUECIMENTO
        if (targetUnit == null) {
          for (var candidate in candidates) {
            bool conflict = false;
            if (_hasData(candidate.fishermanName) &&
                _hasData(pName) &&
                !_compare(candidate.fishermanName, pName)) conflict = true;
            if (_hasData(candidate.boatName) &&
                _hasData(bName) &&
                !_compare(candidate.boatName, bName)) conflict = true;
            if (_hasData(candidate.community) &&
                _hasData(comm) &&
                !_compare(candidate.community, comm)) conflict = true;

            if (!conflict) {
              targetUnit = candidate;
              break;
            }
          }
        }

        if (targetUnit == null) {
          // NOVA UNIDADE
          final newUnit = ProductiveUnit()
            ..uuid = const Uuid().v4()
            ..isSynced = false
            ..searchKey = _generateSearchKey(landing)
            ..fishermanName = pName
            ..boatName = bName
            ..community = comm
            ..category = landing.category
            ..boatType = landing.boatType;

          await isar.productiveUnits.put(newUnit);
        } else {
          // ATUALIZAÇÃO
          targetUnit.fishermanName = targetUnit.fishermanName ?? pName;
          targetUnit.boatName = targetUnit.boatName ?? bName;
          targetUnit.community = targetUnit.community ?? comm;
          targetUnit.category = landing.category ?? targetUnit.category;
          targetUnit.boatType = landing.boatType ?? targetUnit.boatType;
          targetUnit.searchKey = _generateSearchKeyFromUnit(targetUnit);
          targetUnit.isSynced = false;
          await isar.productiveUnits.put(targetUnit);
        }
      }

      // C. Aprende Espécies e Artes
      for (var catchItem in landing.catches) {
        if (catchItem.speciesName != null &&
            catchItem.speciesName!.isNotEmpty) {
          if (await isar.species
                  .filter()
                  .nameEqualTo(catchItem.speciesName!, caseSensitive: false)
                  .findFirst() ==
              null) {
            await isar.species.put(Species()..name = catchItem.speciesName!);
          }
        }
        if (catchItem.fishingGear != null &&
            catchItem.fishingGear!.isNotEmpty) {
          if (await isar.fishingGears
                  .filter()
                  .nameEqualTo(catchItem.fishingGear!, caseSensitive: false)
                  .findFirst() ==
              null) {
            await isar.fishingGears
                .put(FishingGear()..name = catchItem.fishingGear!);
          }
        }
      }

      // D. Faxina
      //await _cleanOrphanUnits(isar);
    });
  }

  // --- 2. DASHBOARD METRICS (Agora com yearWeight declarado!) ---
  Future<Map<String, dynamic>> getDashboardMetrics() async {
    if (kIsWeb) {
      return {
        'trips_month': 0,
        'weight_month': 0.0,
        'dozen_month': 0.0,
        'units_month': 0,
        'pending_sync': 0
      };
    }

    final isar = await db;
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    final startOfYear = DateTime(now.year, 1, 1);

    // Pendências
    final pendingLandings =
        await isar.landings.filter().isSyncedEqualTo(false).count();
    final pendingUnits =
        await isar.productiveUnits.filter().isSyncedEqualTo(false).count();
    final totalPending = pendingLandings + pendingUnits;

    // Dados do Ano
    final yearlyLandings =
        await isar.landings.filter().dateGreaterThan(startOfYear).findAll();

    // Variáveis do Mês
    int monthTrips = 0;
    double monthWeight = 0;
    double monthDozen = 0;

    // Variáveis do Ano (ADICIONADO AGORA)
    double yearWeight = 0;
    double yearDozen = 0;

    final Set<String> monthActiveUnits = {};
    final Set<String> yearActiveUnits = {};

    for (var landing in yearlyLandings) {
      double lWeight = 0;
      double lDozen = 0;

      final pName = landing.fishermanName?.trim() ?? '';
      final bName = landing.boatName?.trim() ?? '';
      final comm = landing.community?.trim() ?? '';

      bool isValidUnit = pName.isNotEmpty || bName.isNotEmpty;
      final String unitKey = '$pName|$bName|$comm';

      for (var fish in landing.catches) {
        final unit = fish.unit?.toLowerCase() ?? '';
        final qty = fish.quantity ?? 0;
        if (unit == 'kg')
          lWeight += qty;
        else if (['dz', 'duzia', 'dúzia'].contains(unit)) lDozen += qty;
      }

      // Soma Totais do Ano (ADICIONADO AGORA)
      yearWeight += lWeight;
      yearDozen += lDozen;

      if (isValidUnit) yearActiveUnits.add(unitKey);

      // Soma Totais do Mês
      if (landing.date.isAfter(startOfMonth) ||
          landing.date.isAtSameMomentAs(startOfMonth)) {
        monthTrips++;
        monthWeight += lWeight;
        monthDozen += lDozen;
        if (isValidUnit) monthActiveUnits.add(unitKey);
      }
    }

    return {
      'pending_sync': totalPending,
      'trips_month': monthTrips,
      'weight_month': monthWeight,
      'dozen_month': monthDozen,
      'units_month': monthActiveUnits.length,
      'trips_year': yearlyLandings.length,
      'weight_year': yearWeight, // Agora a variável existe!
      'dozen_year': yearDozen, // Agora a variável existe!
      'units_year': yearActiveUnits.length,
    };
  }

  // --- 3. BUSCAS E AUXILIARES ---
  Future<List<ProductiveUnit>> searchProductiveUnit(String query) async {
    final isar = await db;
    if (query.isEmpty) {
      return await isar.productiveUnits.where().limit(50).findAll();
    }
    return await isar.productiveUnits
        .filter()
        .searchKeyContains(query, caseSensitive: false)
        .or()
        .fishermanNameContains(query, caseSensitive: false)
        .or()
        .boatNameContains(query, caseSensitive: false)
        .findAll();
  }

  Future<List<String>> searchSpecies(String query) async {
    final isar = await db;
    if (query.isEmpty) {
      final all = await isar.species.where().sortByName().limit(50).findAll();
      return all.map((e) => e.name).toList();
    }
    return (await isar.species
            .filter()
            .nameContains(query, caseSensitive: false)
            .findAll())
        .map((e) => e.name)
        .toList();
  }

  Future<List<String>> searchFishingGear(String query) async {
    final isar = await db;
    if (query.isEmpty) {
      final all =
          await isar.fishingGears.where().sortByName().limit(50).findAll();
      return all.map((e) => e.name).toList();
    }
    return (await isar.fishingGears
            .filter()
            .nameContains(query, caseSensitive: false)
            .findAll())
        .map((e) => e.name)
        .toList();
  }

  Future<void> saveLanding(Landing landing) async =>
      saveLandingWithLearning(landing);

  Future<List<Landing>> getAllLandings() async {
    final isar = await db;
    return await isar.landings.where().sortByDateDesc().findAll();
  }

  Future<String?> getLastUsedLandingPoint() async {
    final isar = await db;
    final last = await isar.landings.where().sortByDateDesc().findFirst();
    return last?.landingPoint;
  }

  Future<void> _cleanOrphanUnits(Isar isar) async {
    final allUnits = await isar.productiveUnits.where().findAll();
    for (var unit in allUnits) {
      final count = await isar.landings
          .filter()
          .fishermanNameEqualTo(unit.fishermanName)
          .and()
          .boatNameEqualTo(unit.boatName)
          .and()
          .communityEqualTo(unit.community)
          .count();

      if (count == 0) {
        await isar.productiveUnits.delete(unit.id);
      }
    }
  }

  String _generateSearchKey(Landing landing) {
    final coreParts = [
      landing.fishermanName,
      landing.boatName,
      landing.community
    ].where((s) => s != null && s.trim().isNotEmpty).toList();
    final coreKey = coreParts.join(' - ');
    return '$coreKey - ${landing.category ?? ""} - ${landing.boatType ?? ""}';
  }

  String _generateSearchKeyFromUnit(ProductiveUnit unit) {
    final coreParts = [unit.fishermanName, unit.boatName, unit.community]
        .where((s) => s != null && s.trim().isNotEmpty)
        .toList();
    final coreKey = coreParts.join(' - ');
    return '$coreKey - ${unit.category ?? ""} - ${unit.boatType ?? ""}';
  }

  bool _compare(String? dbValue, String? newValue) {
    final d = dbValue?.trim().toLowerCase() ?? '';
    final n = newValue?.trim().toLowerCase() ?? '';
    return d == n;
  }

  bool _hasData(String? value) {
    return value != null && value.trim().isNotEmpty;
  }
}
