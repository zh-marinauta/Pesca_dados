import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:isar/isar.dart';
import 'package:marinuata_app/data/isar_service.dart';
import 'package:marinuata_app/data/landing_model.dart';

class SyncService {
  final IsarService _isarService;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  SyncService(this._isarService);

  Future<int> syncPendingLandings() async {
    // Acesso seguro ao banco (pode ser nulo na Web)
    // Se for null, retorna 0 imediatamente
    final isar = await _isarService.db;
    if (isar == null) return 0;

    // 1. Busca pendentes
    final pending =
        await isar.landings.filter().isSyncedEqualTo(false).findAll();

    if (pending.isEmpty) return 0;

    int successCount = 0;

    // 2. Loop de Envio
    for (var landing in pending) {
      try {
        // Converte para lista de linhas (formato tabular para análise)
        final flatRows = landing.toFlatMap();

        // Batch = Pacote. Manda tudo junto ou não manda nada.
        final batch = _firestore.batch();

        for (var row in flatRows) {
          // ID único no Firebase: UUID da viagem + Nome da Espécie
          // Ex: "abc-123_Tainha"
          final docId = "${landing.uuid}_${row['especie']}".replaceAll(' ', '');
          final docRef = _firestore.collection('registros_pesca').doc(docId);

          batch.set(docRef, row);
        }

        // Comita (Salva) na nuvem
        await batch.commit();

        // 3. Marca como sincronizado no celular (Fica Verde)
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
}
