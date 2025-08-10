import 'package:flutter_riverpod/flutter_riverpod.dart';

final mainProvider = StateNotifierProvider<MainNotifier, MainState>((ref) => MainNotifier());

class MainNotifier extends StateNotifier<MainState> {
  MainNotifier() : super(MainState.initial());

  Future<void> loadView() async {
    try {
      state = state.copyWith(mainViewState: MainViewState.showLoading());
      await Future.delayed(Duration(seconds: 1));
      state = state.copyWith(mainViewState: MainViewState.hideLoading());
    } catch (e) {
      state = state.copyWith(mainViewState: MainViewState.hideLoading());
    }
  }
}

class MainState {

  final ProfileState profileState;
  final MainViewState mainViewState;
  
  MainState({
    required this.profileState,
    required this.mainViewState,
  });

  MainState copyWith({
    ProfileState? profileState,
    MainViewState? mainViewState,
  }) {
    return MainState(
      profileState: profileState ?? this.profileState,
      mainViewState: mainViewState ?? this.mainViewState,
    );
  }

  factory MainState.initial() {
    return MainState(
      profileState: ProfileState.initial(),
      mainViewState: MainViewState.hideLoading(),
    );
  }
}

class MainViewState {
  final bool loading;
  MainViewState({
    required this.loading,
  });

  MainViewState copyWith({
    bool? loading,
  }) {
    return MainViewState(
      loading: loading ?? this.loading,
    );
  }

  factory MainViewState.hideLoading() {
    return MainViewState(
      loading: false
    );
  }

  factory MainViewState.showLoading() {
    return MainViewState(
      loading: true
    );
  }
}

class ProfileState {
  final String fullName;

  ProfileState({required this.fullName});


  ProfileState copyWith({
    String? fullName,
  }) {
    return ProfileState(
      fullName: fullName ?? this.fullName,
    );
  }

  factory ProfileState.initial() {
    return ProfileState(
      fullName: 'Bienvenido'
    );
  }
}
