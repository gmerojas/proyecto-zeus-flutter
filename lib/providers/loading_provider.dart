import 'package:flutter_riverpod/flutter_riverpod.dart';

/*
 * STATE
 */
enum LoadingState { hide, loading } 

/*
 * NOTIFIER 
 */
class LoadingNotifier extends StateNotifier<LoadingState> {
  LoadingNotifier() : super(LoadingState.hide);

  void showLoading() {
    state = LoadingState.loading;
  }

  void hideLoading() {
    state = LoadingState.hide;
  }
}

/*
 * PROVIDER
 */
final loadingProvider = StateNotifierProvider<LoadingNotifier, LoadingState>((ref) => LoadingNotifier());