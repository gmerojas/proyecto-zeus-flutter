import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_session_timeout/local_session_timeout.dart';

/// Provider global del StreamController de SessionState de local_session_timeout
final sessionStateStreamProvider = Provider<StreamController<SessionState>>((ref) {
  final controller = StreamController<SessionState>.broadcast();
  ref.onDispose(() {
    controller.close();
  });
  return controller;
});