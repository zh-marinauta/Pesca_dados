import 'package:isar/isar.dart';

part 'landing_model.g.dart';

@Collection()
class Landing {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  bool isSynced = false;
  late DateTime date;

  // --- NOVO CAMPO: ENTREPOSTO ---
  String? landingPoint; // Ex: "Antonina - Praia dos Polacos"

  // --- CABEÇALHO ---
  String? fishermanName;
  String? boatName;
  String? community;
  String? category;
  String? boatType;

  List<Catch> catches = [];
  String? productionSource;

  List<Map<String, dynamic>> toFlatMap() {
    List<Map<String, dynamic>> rows = [];
    for (var fish in catches) {
      rows.add({
        'uuid_viagem': uuid,
        'data': date.toIso8601String(),
        'entreposto_monitorado': landingPoint, // <--- VAI PRO FIREBASE
        'unidade_produtiva': '$fishermanName - $boatName - $community',
        'pescador': fishermanName,
        'barco': boatName,
        'comunidade': community,
        'categoria': category,
        'tipo_embarcacao': boatType,
        'origem': productionSource,
        'especie': fish.speciesName,
        'quantidade': fish.quantity,
        'unidade': fish.unit,
        'preco': fish.price,
        'arte_pesca': fish.fishingGear,
        'pesqueiro': fish.fishingGround,
        'beneficiamento': fish.processingType,
      });
    }
    return rows;
  }
}

@embedded
class Catch {
  String? speciesName;
  double? quantity;
  String? unit;
  double? price;
  String? fishingGear;
  String? fishingGround;
  String? processingType;
}
