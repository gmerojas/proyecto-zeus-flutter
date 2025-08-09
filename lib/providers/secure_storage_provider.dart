import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_zeus/services/export.dart';

final secureStorageProvider = Provider<SecureStorageService>((ref) {
  return SecureStorageService();
});
