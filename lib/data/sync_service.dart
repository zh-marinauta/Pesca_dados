// Arquivo: lib/data/sync_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';
import 'package:marinuata_app/data/isar_service.dart';
import 'package:marinuata_app/data/landing_model.dart';
import 'package:marinuata_app/data/reference_models.dart';

class SyncService {
  final IsarService _isarService;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  SyncService(this._isarService);

  // 1. Coletas
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
          final docId = "${landing.uuid}_${row['especie']}"
              .replaceAll(RegExp(r'\s+'), '');
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
        print("Erro sync landing: $e");
      }
    }
    return successCount;
  }

  // 2. Unidades Produtivas (A função que cria a coleção no Firebase)
  Future<int> syncProductiveUnits() async {
    final isar = await _isarService.db;
    final pendingUnits =
        await isar.productiveUnits.filter().isSyncedEqualTo(false).findAll();

    if (pendingUnits.isEmpty) return 0;

    // Auto-correção de UUIDs antigos
    await isar.writeTxn(() async {
      for (var unit in pendingUnits) {
        if (unit.uuid.isEmpty) {
          unit.uuid = const Uuid().v4();
          await isar.productiveUnits.put(unit);
        }
      }
    });

    final batch = _firestore.batch();
    List<ProductiveUnit> batchList = [];

    for (var unit in pendingUnits) {
      // AQUI O FIREBASE CRIA A COLEÇÃO AUTOMATICAMENTE SE ELA NÃO EXISTIR
      final docRef =
          _firestore.collection('unidades_produtivas').doc(unit.uuid);
      batch.set(docRef, unit.toMap(), SetOptions(merge: true));
      batchList.add(unit);
    }

    if (batchList.isNotEmpty) {
      await batch.commit();
      await isar.writeTxn(() async {
        for (var unit in batchList) {
          unit.isSynced = true;
          await isar.productiveUnits.put(unit);
        }
      });
      return batchList.length;
    }
    return 0;
  }
}
