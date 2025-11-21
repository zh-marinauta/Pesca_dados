import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marinuata_app/data/isar_service.dart'; // Import corrigido

final isarServiceProvider = Provider<IsarService>((ref) {
  return IsarService();
});
