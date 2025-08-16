import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:local_session_timeout/local_session_timeout.dart';
import 'package:proyecto_zeus/controllers/export.dart';
import 'package:proyecto_zeus/providers/export.dart';
import 'package:proyecto_zeus/screens/main/main_controller.dart';

class MainScreen extends ConsumerStatefulWidget {
  final StreamController<SessionState> sessionStateStream;
  const MainScreen({super.key, required this.sessionStateStream});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(mainProvider.notifier).loadView();
    });

    widget.sessionStateStream.add(SessionState.startListening);
  }

  @override
  Widget build(BuildContext context) {
    
    ref.listen<MainState>(mainProvider, (previous, next) {
      if (next.mainViewState.loading) {
        ref.read(loadingProvider.notifier).showLoading();
      } else {
        ref.read(loadingProvider.notifier).hideLoading();
      }
    });

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text('Zeus App'),
        actions: [
          IconButton(
            onPressed: () {
              //ref.read(authControllerProvider.notifier).logout();
              context.push('/home');
            }, 
            icon: Icon(Icons.account_box)
          ),
          IconButton(
            onPressed: () {
              ref.read(authControllerProvider.notifier).logout();
              //context.go('/login');
            }, 
            icon: Icon(Icons.logout)
          )
        ],
      ),
      body: Center(child: Text('Main screen')),
    );
  }

}