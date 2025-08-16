import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_session_timeout/local_session_timeout.dart';
import 'package:proyecto_zeus/controllers/auth_controller.dart';
import 'package:proyecto_zeus/providers/export.dart';
import 'package:proyecto_zeus/providers/session_stream_provider.dart';
import 'package:proyecto_zeus/widgets/export.dart';

void main() async {
  const bool isProduction = bool.fromEnvironment('dart.vm.product');
  await dotenv.load(fileName: isProduction ? ".env.prod" : ".env.dev");
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final sessionStateStream = ref.watch(sessionStateStreamProvider);

    // Configuramos duraciones para timeout por pérdida de foco y por inactividad
    final sessionConfig = SessionConfig(
      invalidateSessionForAppLostFocus: const Duration(minutes: 5),
      invalidateSessionForUserInactivity: const Duration(minutes: 5),
    );

    // Escuchar eventos de timeout
    sessionConfig.stream.listen((SessionTimeoutState timeoutEvent) {
      ref.read(authControllerProvider.notifier).logout();
    });

    return SessionTimeoutManager(
      userActivityDebounceDuration: const Duration(seconds: 1),
      sessionConfig: sessionConfig,
      sessionStateStream: sessionStateStream.stream,
      child: MaterialApp.router(
        routerConfig: router,
        builder: (context, child) {
          return LoadingOverlay(
            child: child!
          );
        },
      ),
    );
  }
}