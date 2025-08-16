import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:local_session_timeout/local_session_timeout.dart';
import 'package:proyecto_zeus/controllers/export.dart';
import 'package:proyecto_zeus/providers/session_stream_provider.dart';
import 'package:proyecto_zeus/screens/export.dart';

/// Clave raíz para GoRouter
final _rootNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authControllerProvider);
  final sessionStateStream = ref.read(sessionStateStreamProvider);
  bool flagLogin = true;
  bool flagMain = true;

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        builder:  (context, state) => SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        builder:  (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: '/main',
        builder:  (context, state) => MainScreen(sessionStateStream: sessionStateStream),
      ),
      GoRoute(
        path: '/home',
        builder:  (context, state) => HomeScreen(),
      ),
    ],
    redirect: (BuildContext context, GoRouterState state) {
      final loggedIn =  authState == AuthState.loggedIn;
      final checking = authState == AuthState.checking;
      final logginIn = state.uri.path == '/login';
      final splashIn = state.uri.path == '/splash';

      if (checking) {
        // No redirigir mientras se está verificando la sesión
        return null;
      }

      if (!loggedIn && !logginIn && flagLogin) {
        // Dejamos de escuchar el tiempo de sesion
        sessionStateStream.add(SessionState.stopListening);

        // Ir a login si no esta logueado y no esta en la pantalla de login
        flagLogin = !flagLogin;
        return '/login';
      }

      if (loggedIn && (logginIn || splashIn) && flagMain) {
        // Ir a main, si esta logueado y esta en la pantalla de login
        flagMain = !flagMain;
        return '/main';
      }

      return null;
    },
    refreshListenable: GoRouterRefreshStream(ref.watch(authControllerProvider.notifier).stream),
  );
});

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    // Notifica inmediatamente para refrescar
    notifyListeners();

    // Escucha el stream y notifica cada vez que hay un nuevo evento
    _subscription = stream.asBroadcastStream().listen(
      (dynamic _) => notifyListeners(),
    );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}