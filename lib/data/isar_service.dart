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
        [LandingSchema, SpeciesSchema, ProductiveUnitSchema, FishingGearSchema],
        directory: dir.path,
        inspector: true,
      );

      if (await isar.species.count() == 0) {
        await isar.writeTxn(() async {
          for (var name in InitialData.species)
            await isar.species.put(Species()
              ..name = name
              ..defaultUnit = 'kg');
        });
      }
      if (await isar.fishingGears.count() == 0) {
        await isar.writeTxn(() async {
          for (var name in InitialData.fishingGears)
            await isar.fishingGears.put(FishingGear()..name = name);
        });
      }
      return isar;
    }
    return Future.value(Isar.getInstance());
  }

  // --- SALVAR COM INTELIGÊNCIA E FAXINA ---
  Future<void> saveLandingWithLearning(Landing landing) async {
    final isar = await db;

    await isar.writeTxn(() async {
      // 1. Salva a Coleta
      await isar.landings.put(landing);

      // 2. Aprende Unidade Produtiva (Lógica de Inserção/Atualização)
      final pName = landing.fishermanName ?? '';
      final bName = landing.boatName ?? '';
      bool isUnidentified = pName.trim().isEmpty ||
          pName.contains('Não Identificado') ||
          bName.trim().isEmpty ||
          bName.contains('Não Identificado');

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
          final existingUnit = await isar.productiveUnits
              .filter()
              .searchKeyStartsWith(coreKey, caseSensitive: false)
              .findFirst();

          if (existingUnit == null) {
            // Cria Novo
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
            // Atualiza (Lógica simplificada: sempre atualiza o existente com os dados mais recentes daquele barco)
            // Isso garante que a correção de typo no formulário reflita aqui
            existingUnit.category = landing.category;
            existingUnit.boatType = landing.boatType;
            existingUnit.searchKey =
                '$coreKey - ${landing.category ?? ""} - ${landing.boatType ?? ""}';
            await isar.productiveUnits.put(existingUnit);
          }
        }
      }

      // 3. Aprende Espécies
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

      // 4. FAXINA (Limpa unidades órfãs/erradas)
      // Chamamos a função de limpeza dentro da transação para ser seguro
      await _cleanOrphanUnits(isar);
    });
  }

  // --- FUNÇÃO DE LIMPEZA (Privada) ---
  Future<void> _cleanOrphanUnits(Isar isar) async {
    // Busca todas as unidades produtivas cadastradas
    final allUnits = await isar.productiveUnits.where().findAll();

    for (var unit in allUnits) {
      // Conta quantos desembarques existem com exatamente esses dados
      final count = await isar.landings
          .filter()
          .fishermanNameEqualTo(unit.fishermanName)
          .and()
          .boatNameEqualTo(unit.boatName)
          .and()
          .communityEqualTo(unit.community)
          .count();

      // Se count for 0, significa que não tem nenhum desembarque usando esse nome.
      // Logo, foi um typo corrigido ou deletado. Podemos apagar do autocomplete.
      if (count == 0) {
        print("🧹 Faxina: Removendo unidade órfã '${unit.searchKey}'");
        await isar.productiveUnits.delete(unit.id);
      }
    }
  }

  // --- Getters ---
  Future<Map<String, dynamic>> getDashboardMetrics() async {
    if (kIsWeb)
      return {
        'trips_month': 0,
        'weight_month': 0.0,
        'dozen_month': 0.0,
        'units_month': 0,
        'pending_sync': 0
      };

    final isar = await db;
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    final startOfYear = DateTime(now.year, 1, 1);
    final yearlyLandings =
        await isar.landings.filter().dateGreaterThan(startOfYear).findAll();
    final pendingCount =
        await isar.landings.filter().isSyncedEqualTo(false).count();

    int monthTrips = 0;
    double monthWeight = 0;
    double monthDozen = 0;
    final Set<String> monthActiveUnits = {};

    int yearTrips = 0;
    double yearWeight = 0;
    double yearDozen = 0;
    final Set<String> yearActiveUnits = {};

    for (var landing in yearlyLandings) {
      double lWeight = 0;
      double lDozen = 0;

      // Regra de validade para dashboard
      final pName = landing.fishermanName ?? '';
      final bName = landing.boatName ?? '';
      bool isValidUnit =
          (!pName.contains('Não Identificado') && pName.isNotEmpty) ||
              (!bName.contains('Não Identificado') && bName.isNotEmpty);

      final String unitKey = '$pName - $bName';

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
      if (isValidUnit) yearActiveUnits.add(unitKey);

      if (landing.date.isAfter(startOfMonth) ||
          landing.date.isAtSameMomentAs(startOfMonth)) {
        monthTrips++;
        monthWeight += lWeight;
        monthDozen += lDozen;
        if (isValidUnit) monthActiveUnits.add(unitKey);
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
