import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:isar/isar.dart';
import 'package:marinuata_app/data/isar_service.dart';
import 'package:marinuata_app/data/landing_model.dart';
import 'package:marinuata_app/data/reference_models.dart';

class SyncService {
  final IsarService _isarService;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  SyncService(this._isarService);

  // --- CORREÇÃO: O TIPO DE RETORNO DEVE SER EXPLÍCITO ---
  Future<Map<String, int>> syncAll() async {
    int landings = await syncPendingLandings();
    int units = await syncProductiveUnits();
    int spots = await syncPendingFishingSpots();

    return {
      'landings': landings,
      'units': units,
      'spots': spots,
      'total': landings + units + spots
    };
  }

  // 1. Sincronizar Viagens
  Future<int> syncPendingLandings() async {
    final isar = await _isarService.db;
    final pending =
        await isar.landings.filter().isSyncedEqualTo(false).findAll();

    if (pending.isEmpty) return 0;
    int successCount = 0;

    for (var landing in pending) {
      try {
        final flatRows = landing.toFlatMap();
        final batch = _firestore.batch();

        for (var row in flatRows) {
          final docId = "${landing.uuid}_${row['especie']}".replaceAll(' ', '');
          final docRef = _firestore.collection('registros_pesca').doc(docId);
          batch.set(docRef, row);
        }

        await batch.commit();

        await isar.writeTxn(() async {
          landing.isSynced = true;
          await isar.landings.put(landing);
        });

        successCount++;
      } catch (e) {
        print("Erro ao sincronizar viagem ${landing.uuid}: $e");
      }
    }
    return successCount;
  }

  // 2. Sincronizar Unidades Produtivas
  Future<int> syncProductiveUnits() async {
    final isar = await _isarService.db;
    final pending =
        await isar.productiveUnits.filter().isSyncedEqualTo(false).findAll();

    if (pending.isEmpty) return 0;
    int successCount = 0;
    final batch = _firestore.batch();
    bool hasData = false;

    for (var unit in pending) {
      try {
        final docRef =
            _firestore.collection('unidades_produtivas').doc(unit.uuid);
        batch.set(docRef, unit.toMap(), SetOptions(merge: true));
        hasData = true;
        successCount++;
      } catch (e) {
        print("Erro ao preparar unidade ${unit.searchKey}: $e");
      }
    }

    if (hasData) {
      await batch.commit();
      await isar.writeTxn(() async {
        for (var unit in pending) {
          unit.isSynced = true;
          await isar.productiveUnits.put(unit);
        }
      });
    }
    return successCount;
  }

  // 3. Sincronizar Pesqueiros
  Future<int> syncPendingFishingSpots() async {
    final isar = await _isarService.db;
    final pending =
        await isar.fishingSpots.filter().isSyncedEqualTo(false).findAll();

    if (pending.isEmpty) return 0;
    int successCount = 0;
    final batch = _firestore.batch();
    bool hasData = false;

    for (var spot in pending) {
      try {
        final docRef = _firestore.collection('pesqueiros').doc(spot.uuid);
        batch.set(docRef, spot.toMap(), SetOptions(merge: true));
        hasData = true;
        successCount++;
      } catch (e) {
        print("Erro ao preparar pesqueiro ${spot.name}: $e");
      }
    }

    if (hasData) {
      await batch.commit();
      await isar.writeTxn(() async {
        for (var spot in pending) {
          spot.isSynced = true;
          await isar.fishingSpots.put(spot);
        }
      });
    }
    return successCount;
  }
}
