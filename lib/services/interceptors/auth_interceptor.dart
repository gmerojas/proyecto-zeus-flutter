import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_zeus/controllers/auth_controller.dart';
import 'package:proyecto_zeus/providers/secure_storage_provider.dart';

class AuthInterceptor extends Interceptor {
  final Ref ref;

  AuthInterceptor(this.ref);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    debugPrint("=== REQUEST ===");
    debugPrint("URI: ${options.uri}");
    debugPrint("Method: ${options.method}");
    debugPrint("Headers: ${jsonEncode(options.headers)}");

    // Obtener el token almacenado (por ejemplo desde un provider o secure storage)
    final secureStorage = ref.read(secureStorageProvider);
    String? token = await secureStorage.readData('token');

    // Si el token existe y no está vacío, agregarlo en los headers para autorización
    if (token != null && token.isNotEmpty) {
      options.headers["Authorization"] = "Bearer $token";
    }

    if (options.data != null) {
      try {
        // Intenta formatear el body como JSON
        var prettyData = const JsonEncoder.withIndent('  ').convert(options.data);
        debugPrint("Body: $prettyData");
      } catch (e) {
        // Si no es JSON válido, imprime el valor tal cual
        debugPrint("Body: ${options.data}");
      }
    }
    debugPrint("================");

    // Continuar con la petición
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint("=== RESPONSE ===");
    debugPrint("URI: ${response.requestOptions.uri}");
    debugPrint("Status Code: ${response.statusCode}");
    debugPrint("Headers: ${jsonEncode(response.headers.map)}");
    try {
      // Intenta formatear la respuesta como JSON
      var prettyData = const JsonEncoder.withIndent('  ').convert(response.data);
      debugPrint("Response Body: $prettyData");
    } catch (e) {
      // Si no es JSON válido, imprime el valor tal cual
      debugPrint("Response Body: ${response.data}");
    }
    debugPrint("================");
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {

    debugPrint("=== ERROR ===");
    if (err.response != null) {
      debugPrint("URI: ${err.response!.requestOptions.uri}");
      debugPrint("Status Code: ${err.response!.statusCode}");
      try {
        var prettyData = const JsonEncoder.withIndent('  ').convert(err.response!.data);
        debugPrint("Error Response Body: $prettyData");
      } catch (e) {
        debugPrint("Error Response Body: ${err.response!.data}");
      }
    } else {
      debugPrint("Error: ${err.message}");
    }
    debugPrint("================");

    // Si recibimos un error 401 (Unauthorized), hacer logout automáticamente
    if (err.response?.statusCode == 401) {
      // Llamar al logout desde el AuthController (usando Riverpod)
      ref.read(authControllerProvider.notifier).logout();
    }

    // Continuar con el manejo del error
    super.onError(err, handler);
  }
}