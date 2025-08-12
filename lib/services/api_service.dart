import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_zeus/services/interceptors/auth_interceptor.dart';

class ApiService {
  final Dio _dio;

  ApiService(Ref ref)
      : _dio = Dio(BaseOptions(baseUrl: '${dotenv.env['PROTOCOL']}://${dotenv.env['API_URL']}')) {
    // Agregar interceptor de autenticacion
    _dio.interceptors.add(AuthInterceptor(ref));
  }

  Future<Response> getData(String path) async {
    // Ejemplo llamada GET
    return _dio.get(path);
  }

  Future<Response> postData(String path, Map<String, dynamic> data) async {
    return _dio.post(path, data: data);
  }

  // Otros métodos según necesidad
}
