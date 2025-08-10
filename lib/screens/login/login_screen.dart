import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_zeus/controllers/export.dart';
import 'package:proyecto_zeus/providers/export.dart';
import 'package:proyecto_zeus/screens/login/login_controller.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(loginProvider.notifier).loadView();
    });
  }

  @override
  Widget build(BuildContext context) {

    ref.listen<LoginState>(loginProvider, (previous, next) {
      if (next.loginViewState.loading) {
        ref.read(loadingProvider.notifier).showLoading();
      } else {
        ref.read(loadingProvider.notifier).hideLoading();
      }
    });

    return Scaffold(
      backgroundColor: Colors.purple,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Login', style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.w500)),
            ElevatedButton(
              onPressed: () {
                ref.read(authControllerProvider.notifier).login();
              },
              child: const Text('Iniciar sesión'),
            ),
          ],
        ),
      ),
    );
  }
}