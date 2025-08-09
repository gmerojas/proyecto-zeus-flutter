import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:proyecto_zeus/controllers/auth_controller.dart';
import 'package:proyecto_zeus/widgets/loading/loading_overlay.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (authState == AuthState.loggedOut) {
        context.go('/login');
      } else if (authState == AuthState.loggedIn) {
        context.go('/home');
      } else {
        // Si el esto es checking, no hacer nada y permanecer en SPLASH
      }
    });

    return LoadingOverlay(
      isLoading: authState == AuthState.checking,
      child: Scaffold(
        body: Center(
          child: Text('Splash screen')
        ),
      ),
    );
  }
}