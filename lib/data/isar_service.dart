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
  // Arquivo: lib/data/isar_service.dart

  // ... (início da classe)

  Future<void> saveLandingWithLearning(Landing landing) async {
    final isar = await db;

    await isar.writeTxn(() async {
      // 1. Salva a Coleta (Sempre salva)
      await isar.landings.put(landing);

      // 2. Aprende Unidade Produtiva
      final pName = landing.fishermanName ?? '';
      final bName = landing.boatName ?? '';

      // Regra: Se tiver pelo menos um nome válido, aprende
      bool isValidToLearn =
          (!pName.contains('Não Identificado') && pName.isNotEmpty) ||
              (!bName.contains('Não Identificado') && bName.isNotEmpty);

      if (isValidToLearn) {
        final coreKey = [
          landing.fishermanName,
          landing.boatName,
          landing.community
        ].where((s) => s != null && s.trim().isNotEmpty).join(' - ');

        if (coreKey.isNotEmpty) {
          // Tenta achar a unidade no banco
          final existingUnit = await isar.productiveUnits
              .filter()
              .searchKeyStartsWith(coreKey, caseSensitive: false)
              .findFirst();

          if (existingUnit == null) {
            // --- NÃO MUDAR AQUI (CRIA NOVO) ---
            final newUnit = ProductiveUnit()
              ..searchKey =
                  '$coreKey - ${landing.category ?? ""} - ${landing.boatType ?? ""}'
              ..fishermanName = landing.fishermanName
              ..boatName = landing.boatName
              ..community = landing.community
              ..category = landing.category
              ..boatType = landing.boatType;
            await isar.productiveUnits.put(newUnit);
          } else {
            // --- OTIMIZAÇÃO AQUI (ATUALIZA EXISTENTE) ---
            // Substitua o código antigo deste 'else' por este bloco:

            // Verifica se houve alguma mudança real nos campos complementares
            final bool hasChanges = existingUnit.category != landing.category ||
                existingUnit.boatType != landing.boatType;

            if (hasChanges) {
              // Só se mudou algo, atualizamos o registro
              existingUnit.category = landing.category;
              existingUnit.boatType = landing.boatType;
              existingUnit.searchKey =
                  '$coreKey - ${landing.category ?? ""} - ${landing.boatType ?? ""}';

              await isar.productiveUnits.put(existingUnit);
              print(
                  "🔄 Unidade Produtiva atualizada: ${existingUnit.searchKey}");
            } else {
              // Se for igual, não faz nada (economiza processamento e sync)
              print("✅ Unidade Produtiva sem alterações. Ignorando update.");
            }
          }
        }
      }

      // 3. Aprende Espécies (Código original continua aqui...)
      for (var catchItem in landing.catches) {
        // ... (manter o resto do código de espécies igual)
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
        // ... (manter código de artes de pesca igual)
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

      // 4. Faxina (Código original continua aqui...)
      await _cleanOrphanUnits(isar);
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

  // Adicione no lib/data/isar_service.dart
  Future<void> deleteLandings(List<int> ids) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.landings.deleteAll(ids);
    });
  }
}
