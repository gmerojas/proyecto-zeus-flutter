import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:proyecto_zeus/widgets/loading/loading_overlay.dart';

import '../../controllers/export.dart';


class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LoadingOverlay(
      isLoading: false,
      child: Scaffold(
        appBar: AppBar(title: const Text('Login')),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              ref.read(authControllerProvider.notifier).login();
              context.go('/home');
            },
            child: const Text('Iniciar sesión'),
          ),
        ),
      ),
    );
  }
}