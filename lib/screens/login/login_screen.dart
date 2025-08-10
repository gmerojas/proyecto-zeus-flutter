import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
    final loginController = ref.read(loginProvider.notifier);

    ref.listen<LoginState>(loginProvider, (previous, next) {
      if (next.loginViewState.loading) {
        ref.read(loadingProvider.notifier).showLoading();
      } else {
        ref.read(loadingProvider.notifier).hideLoading();
      }

      if (previous?.loginNavigateState.nextPage != next.loginNavigateState.nextPage) {
        context.go(next.loginNavigateState.nextPage);
      }
    });

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Login', style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.w500)),
            ElevatedButton(
              onPressed: () {
                //ref.read(authControllerProvider.notifier).login();
                //context.go('/home');
                loginController.loginPassword();
              },
              child: const Text('Iniciar sesión'),
            ),
          ],
        ),
      ),
    );
  }
}