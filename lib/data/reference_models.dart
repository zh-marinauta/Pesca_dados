import 'package:isar/isar.dart';

part 'reference_models.g.dart';

@Collection()
class Species {
  Id id = Isar.autoIncrement;
  @Index(type: IndexType.value, caseSensitive: false)
  late String name;
  String? defaultUnit;
}

@Collection()
class FishingGear {
  Id id = Isar.autoIncrement;
  @Index(type: IndexType.value, caseSensitive: false)
  late String name;
}

@Collection()
class ProductiveUnit {
  Id id = Isar.autoIncrement;

  // --- NOVOS CAMPOS OBRIGATÓRIOS PARA SINCRONIZAÇÃO ---
  @Index(unique: true, replace: true)
  late String uuid; // Identidade única universal

  bool isSynced = false; // Controle de envio para nuvem
  // ----------------------------------------------------

  @Index(type: IndexType.value, caseSensitive: false)
  late String searchKey; // "João - Barco Alpha - Vila Velha..."

  String? fishermanName;
  String? boatName;
  String? community;
  String? category;
  String? boatType;

  // Helper para converter para o formato do Firebase
  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'pescador': fishermanName,
      'barco': boatName,
      'comunidade': community,
      'categoria': category,
      'tipo_embarcacao': boatType,
      'search_key': searchKey,
      'last_updated': DateTime.now().toIso8601String(),
    };
  }
}
