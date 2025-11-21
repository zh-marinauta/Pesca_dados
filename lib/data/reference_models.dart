import 'package:isar/isar.dart';

part 'reference_models.g.dart';

@Collection()
class Species {
  Id id = Isar.autoIncrement;
  @Index(type: IndexType.value, caseSensitive: false)
  late String name;
  String? defaultUnit;
}

// --- NOVA TABELA ---
@Collection()
class FishingGear {
  Id id = Isar.autoIncrement;
  @Index(type: IndexType.value, caseSensitive: false)
  late String name;
}

@Collection()
class ProductiveUnit {
  Id id = Isar.autoIncrement;

  @Index(
      type: IndexType.value, caseSensitive: false) // Indexado para busca rápida
  late String
      searchKey; // O texto concatenado: "João - Barco Alpha - Vila Velha"

  // Dados granulares para preencher o formulário automaticamente
  String? fishermanName;
  String? boatName;
  String? community;
  String? category;
  String? boatType;
}
