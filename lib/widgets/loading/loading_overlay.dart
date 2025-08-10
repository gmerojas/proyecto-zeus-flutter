import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_zeus/providers/export.dart';

// Widget reusable para pantalla de carga
class LoadingOverlay extends ConsumerWidget {
  final Widget child;

  const LoadingOverlay({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loadingProvider);
    return Stack(
      children: [
        child, // Pantalla principal
        if (state == LoadingState.loading)
          Opacity(
            opacity: 0.1,
            child: ModalBarrier(dismissible: false, color: Colors.black),
          ),
        if (state == LoadingState.loading)
          Center(
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }
}
