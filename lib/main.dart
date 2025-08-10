import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_zeus/widgets/export.dart';

import 'config/export.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: routerConfig,
      builder: (context, child) {
        return LoadingOverlay(
          child: child!
        );
      },
    );
  }
}