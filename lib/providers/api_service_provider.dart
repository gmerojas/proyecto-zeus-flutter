import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_zeus/services/api_service.dart';

final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService(ref);
});
