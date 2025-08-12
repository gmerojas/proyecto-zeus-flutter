import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_zeus/providers/api_service_provider.dart';
import 'package:proyecto_zeus/providers/export.dart';
import 'package:proyecto_zeus/services/api_service.dart';
import 'package:proyecto_zeus/services/export.dart';

// Define estados de autenticación
enum AuthState { checking, loggedIn, loggedOut }

class AuthController extends StateNotifier<AuthState> {
  final ApiService _apiService;
  final SecureStorageService _secureStorage;
  
  AuthController(this._apiService, this._secureStorage) : super(AuthState.checking) {
    recuperarSesion();
  }

  Future<void> recuperarSesion() async {
    await Future.delayed(Duration(seconds: 3));

    String? token = await _secureStorage.readData('token');
    bool tieneToken = token != null && token.isNotEmpty;

    if(tieneToken) {
      state = AuthState.loggedIn;
    } else {
      state = AuthState.loggedOut;
    }
  }

  void login() async {
    try {
      /*
      * Llamada a inicio de sesion
      */
      final response = await _apiService.postData('/auth/login', {'username':'juan', 'password':'juan'});
      debugPrint(response.statusCode.toString());
      await Future.delayed(Duration(seconds: 1));

      await _secureStorage.writeData('token', 'khfkfkytfytfytfjytfjytfjytfjytf');
      state = AuthState.loggedIn;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void logout() async {
    await _secureStorage.deleteData('token');
    state = AuthState.loggedOut;
  }
}

final authControllerProvider = StateNotifierProvider<AuthController, AuthState>((ref) {
  // Consumimos el provider SecureStorageService
  final secureStorage = ref.read(secureStorageProvider);
  final apiService = ref.read(apiServiceProvider);
  // Retornamos el controlador
  return AuthController(apiService,secureStorage);
});