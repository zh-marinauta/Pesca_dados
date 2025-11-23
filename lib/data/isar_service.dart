import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
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
        [
          LandingSchema,
          SpeciesSchema,
          ProductiveUnitSchema,
          FishingGearSchema,
          FishingSpotSchema
        ],
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

  // --- SALVAR COM LÓGICA DE APRENDIZADO ---
  Future<void> saveLandingWithLearning(Landing landing) async {
    final isar = await db;

    await isar.writeTxn(() async {
      await isar.landings.put(landing);

      final inFisherman = landing.fishermanName?.trim() ?? '';
      final inBoat = landing.boatName?.trim() ?? '';
      final inComm = landing.community?.trim() ?? '';
      final inCat = landing.category?.trim() ?? '';
      final inType = landing.boatType?.trim() ?? '';

      bool isValidToLearn =
          (!inFisherman.toLowerCase().contains('não identificado') &&
                  inFisherman.isNotEmpty) ||
              (!inBoat.toLowerCase().contains('não identificado') &&
                  inBoat.isNotEmpty);

      if (!isValidToLearn) return;

      List<ProductiveUnit> candidates = [];
      if (inFisherman.isNotEmpty) {
        candidates = await isar.productiveUnits
            .filter()
            .fishermanNameEqualTo(inFisherman, caseSensitive: false)
            .findAll();
      } else if (inBoat.isNotEmpty) {
        candidates = await isar.productiveUnits
            .filter()
            .boatNameEqualTo(inBoat, caseSensitive: false)
            .findAll();
      }

      ProductiveUnit? targetUnit;

      for (var unit in candidates) {
        bool hasConflict = false;
        if (_hasConflict(unit.fishermanName, inFisherman)) hasConflict = true;
        if (_hasConflict(unit.boatName, inBoat)) hasConflict = true;
        if (_hasConflict(unit.community, inComm)) hasConflict = true;
        if (_hasConflict(unit.category, inCat)) hasConflict = true;
        if (_hasConflict(unit.boatType, inType)) hasConflict = true;

        if (!hasConflict) {
          targetUnit = unit;
          break;
        }
      }

      if (targetUnit != null) {
        // ATUALIZAÇÃO (Preenche vazios)
        bool changed = false;
        if (inFisherman.isNotEmpty &&
            (targetUnit.fishermanName?.isEmpty ?? true)) {
          targetUnit.fishermanName = inFisherman;
          changed = true;
        }
        if (inBoat.isNotEmpty && (targetUnit.boatName?.isEmpty ?? true)) {
          targetUnit.boatName = inBoat;
          changed = true;
        }
        if (inComm.isNotEmpty && (targetUnit.community?.isEmpty ?? true)) {
          targetUnit.community = inComm;
          changed = true;
        }
        if (inCat.isNotEmpty && (targetUnit.category?.isEmpty ?? true)) {
          targetUnit.category = inCat;
          changed = true;
        }
        if (inType.isNotEmpty && (targetUnit.boatType?.isEmpty ?? true)) {
          targetUnit.boatType = inType;
          changed = true;
        }

        if (changed) {
          targetUnit.searchKey = _generateSearchKey(
            targetUnit.fishermanName,
            targetUnit.boatName,
            targetUnit.community,
            targetUnit.category,
            targetUnit.boatType,
          );
          targetUnit.isSynced = false;
          await isar.productiveUnits.put(targetUnit);
        }
      } else {
        // NOVO REGISTRO
        final exactMatch = candidates.any((u) =>
            (u.fishermanName ?? '') == inFisherman &&
            (u.boatName ?? '') == inBoat &&
            (u.community ?? '') == inComm &&
            (u.category ?? '') == inCat &&
            (u.boatType ?? '') == inType);

        if (!exactMatch) {
          final newUnit = ProductiveUnit()
            ..fishermanName = inFisherman
            ..boatName = inBoat
            ..community = inComm
            ..category = inCat
            ..boatType = inType
            ..searchKey =
                _generateSearchKey(inFisherman, inBoat, inComm, inCat, inType)
            ..isSynced = false;

          await isar.productiveUnits.put(newUnit);
        }
      }

      for (var catchItem in landing.catches) {
        // Espécies
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
        // Artes de Pesca
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
        // NOVO: Pesqueiros (Fishing Spots)
        if (catchItem.fishingGround != null &&
            catchItem.fishingGround!.isNotEmpty) {
          if (await isar.fishingSpots
                  .filter()
                  .nameEqualTo(catchItem.fishingGround!, caseSensitive: false)
                  .findFirst() ==
              null) {
            // Cria com isSynced = false (padrão) para ser enviado depois
            await isar.fishingSpots
                .put(FishingSpot()..name = catchItem.fishingGround!);
          }
        }
      }
    });
  }

  // --- MÉTRICAS DO DASHBOARD (CORRIGIDA PARA UPDATE) ---
  Future<Map<String, dynamic>> getDashboardMetrics() async {
    if (kIsWeb) {
      return {
        'trips_month': 0,
        'weight_month': 0.0,
        'dozen_month': 0.0,
        'units_month': 0,
        'pending_sync': 0,
        'units_year': 0
      };
    }

    final isar = await db;
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    final startOfYear = DateTime(now.year, 1, 1);

    final yearlyLandings =
        await isar.landings.filter().dateGreaterThan(startOfYear).findAll();
    final pendingCount =
        await isar.landings.filter().isSyncedEqualTo(false).count();

    // Carrega TODA a frota cadastrada para fazer o cruzamento
    final allFleet = await isar.productiveUnits.where().findAll();

    int monthTrips = 0;
    double monthWeight = 0;
    double monthDozen = 0;

    int yearTrips = 0;
    double yearWeight = 0;
    double yearDozen = 0;

    // Sets de UUIDs. Isso garante que se "João" e "João Completo" mapearem
    // para o mesmo ID da frota, contam só como 1.
    final Set<String> monthActiveUnits = {};
    final Set<String> yearActiveUnits = {};

    for (var landing in yearlyLandings) {
      double lWeight = 0;
      double lDozen = 0;

      final pName = landing.fishermanName ?? '';
      final bName = landing.boatName ?? '';

      // Validação básica para ignorar "Não Identificado" da contagem
      bool isValidUnit = (!pName.toLowerCase().contains('não identificado') &&
              pName.isNotEmpty) ||
          (!bName.toLowerCase().contains('não identificado') &&
              bName.isNotEmpty);

      // --- LÓGICA DE CORRESPONDÊNCIA INTELIGENTE ---
      String? activeId;

      if (isValidUnit) {
        // Tenta encontrar a qual unidade da frota essa viagem pertence
        final match = _findBestMatch(landing, allFleet);

        if (match != null) {
          // Se encontrou na frota, usa o UUID oficial (assim Atualização conta como o mesmo)
          activeId = match.uuid;
        } else {
          // Se não encontrou (ex: foi deletado da frota mas a viagem existe),
          // cria uma chave temporária única para não deixar de contar a atividade.
          // Isso cobre o caso de "Alteração" que gerou conflito e virou algo novo.
          activeId =
              'temp_${pName}|${bName}|${landing.community}|${landing.category}|${landing.boatType}';
        }
      }

      for (var fish in landing.catches) {
        final unit = fish.unit?.toLowerCase() ?? '';
        final qty = fish.quantity ?? 0;
        if (unit == 'kg')
          lWeight += qty;
        else if (unit == 'dz' || unit == 'duzia' || unit == 'dúzia')
          lDozen += qty;
      }

      yearTrips++;
      yearWeight += lWeight;
      yearDozen += lDozen;

      if (activeId != null) yearActiveUnits.add(activeId);

      if (landing.date.isAfter(startOfMonth) ||
          landing.date.isAtSameMomentAs(startOfMonth)) {
        monthTrips++;
        monthWeight += lWeight;
        monthDozen += lDozen;
        if (activeId != null) monthActiveUnits.add(activeId);
      }
    }

    return {
      'pending_sync': pendingCount,
      'trips_month': monthTrips,
      'weight_month': monthWeight,
      'dozen_month': monthDozen,
      'units_month': monthActiveUnits.length,
      'trips_year': yearTrips,
      'weight_year': yearWeight,
      'dozen_year': yearDozen,
      'units_year': yearActiveUnits.length,
    };
  }

  // --- NOVA FUNÇÃO AUXILIAR PARA O DASHBOARD ---
  ProductiveUnit? _findBestMatch(
      Landing landing, List<ProductiveUnit> allFleet) {
    final lName = landing.fishermanName?.trim() ?? '';
    final lBoat = landing.boatName?.trim() ?? '';

    // Filtra candidatos (Nome ou Barco igual)
    final candidates = allFleet.where((unit) {
      bool nameMatch = lName.isNotEmpty &&
          (unit.fishermanName?.trim() ?? '').toLowerCase() ==
              lName.toLowerCase();
      bool boatMatch = lBoat.isNotEmpty &&
          (unit.boatName?.trim() ?? '').toLowerCase() == lBoat.toLowerCase();
      return nameMatch || boatMatch;
    }).toList();

    for (var unit in candidates) {
      // Verifica conflito em TODOS os campos
      bool hasConflict = false;
      if (_hasConflict(unit.fishermanName, lName)) hasConflict = true;
      if (_hasConflict(unit.boatName, lBoat)) hasConflict = true;
      if (_hasConflict(unit.community, landing.community)) hasConflict = true;
      if (_hasConflict(unit.category, landing.category)) hasConflict = true;
      if (_hasConflict(unit.boatType, landing.boatType)) hasConflict = true;

      // Se não tiver conflito, é um MATCH! (Seja exato ou atualização)
      if (!hasConflict) {
        return unit;
      }
    }
    return null;
  }

  bool _hasConflict(String? dbValue, String? inputValue) {
    final dbV = dbValue?.trim() ?? '';
    final inV = inputValue?.trim() ?? '';

    if (dbV.isEmpty)
      return false; // Se o banco está vazio, aceita o novo (Update)
    if (inV.isEmpty)
      return false; // Se o input está vazio, aceita o velho (Update)

    return dbV.toLowerCase() != inV.toLowerCase(); // Se diferentes, Conflito.
  }

  String _generateSearchKey(
      String? p, String? b, String? c, String? cat, String? type) {
    return [p, b, c, cat, type]
        .where((e) => e != null && e.trim().isNotEmpty)
        .join(' - ');
  }

  Future<void> deleteLandings(List<Id> ids) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.landings.deleteAll(ids);
    });
  }

  Future<List<ProductiveUnit>> searchProductiveUnit(String query) async {
    final isar = await db;
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

  // NOVO: Busca de Pesqueiros
  Future<List<String>> searchFishingSpot(String query) async {
    final isar = await db;
    if (query.isEmpty) {
      final all =
          await isar.fishingSpots.where().sortByName().limit(50).findAll();
      return all.map((e) => e.name).toList();
    }
    return (await isar.fishingSpots
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
}
