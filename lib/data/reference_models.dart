import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

part 'reference_models.g.dart';

@Collection()
class Species {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  String uuid = const Uuid().v4();

  @Index(type: IndexType.value, caseSensitive: false)
  String name = '';

  String? defaultUnit;
}

@Collection()
class FishingGear {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  String uuid = const Uuid().v4();

  @Index(type: IndexType.value, caseSensitive: false)
  String name = '';
}

@Collection()
class ProductiveUnit {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  String uuid = const Uuid().v4();

  bool isSynced = false;

  @Index(type: IndexType.value, caseSensitive: false)
  String searchKey = '';

  String? fishermanName;
  String? boatName;
  String? community;
  String? category;
  String? boatType;

  // --- CORREÇÃO DO ERRO ---
  // Método necessário para enviar os dados para o Firebase (SyncService)
  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'searchKey': searchKey,
      'fishermanName': fishermanName,
      'boatName': boatName,
      'community': community,
      'category': category,
      'boatType': boatType,
      'updatedAt': DateTime.now().toIso8601String(),
    };
  }
}
