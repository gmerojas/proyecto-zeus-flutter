import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginProvider = StateNotifierProvider.autoDispose<LoginNotifier, LoginState>((ref) => LoginNotifier());

class LoginNotifier extends StateNotifier<LoginState> {
  /*
   * CONSTRUCTOR
   */
  LoginNotifier() : super(LoginState.initial());

  Future<void> loadView() async {
    try {
      state = state.copyWith(loginViewState: LoginViewState.showLoading());
      await Future.delayed(Duration(seconds: 1));
      state = state.copyWith(loginViewState: LoginViewState.hideLoading());
    } catch (e) {
      state = state.copyWith(loginViewState: LoginViewState.hideLoading());
    }
  }

  Future<void> loginPassword() async {
    try {
      state = state.copyWith(loginViewState: LoginViewState.showLoading());
      await Future.delayed(Duration(seconds: 1));
      state = state.copyWith(loginViewState: LoginViewState.hideLoading());//, loginNavigateState: LoginNavigateState.goMain());
    } catch (e) {
      state = state.copyWith(loginViewState: LoginViewState.hideLoading());
    }
  }
}

/*
 * LOGIN_STATE
 */
class LoginState {
  final LoginViewState loginViewState;
  //final LoginNavigateState loginNavigateState;

  LoginState({
    required this.loginViewState, 
    //required this.loginNavigateState
  });

  LoginState copyWith({
    LoginViewState? loginViewState,
    //LoginNavigateState? loginNavigateState,
  }) {
    return LoginState(
      loginViewState: loginViewState ?? this.loginViewState,
      //loginNavigateState: loginNavigateState ?? this.loginNavigateState,
    );
  }

  factory LoginState.initial() {
    return LoginState(
      loginViewState: LoginViewState.hideLoading(),
      //loginNavigateState: LoginNavigateState.goLogin()
    );
  }
}

/*
 * LOGIN_VIEW_STATE
 */
class LoginViewState {
  final bool loading;

  LoginViewState({required this.loading});

  LoginViewState copyWith({
    bool? loading
  }) {
    return LoginViewState(
      loading: loading ?? this.loading
    );
  }

  factory LoginViewState.hideLoading() {
    return LoginViewState(
      loading: false
    );
  }

  factory LoginViewState.showLoading() {
    return LoginViewState(
      loading: true
    );
  }
}

/*
 * LOGIN_VIEW_STATE
 */
class LoginNavigateState {
  final String nextPage;

  LoginNavigateState({required this.nextPage});

  LoginNavigateState copyWith({
    String? nextPage
  }) {
    return LoginNavigateState(
      nextPage: nextPage ?? this.nextPage
    );
  }

  factory LoginNavigateState.goLogin() {
    return LoginNavigateState(
      nextPage: '/login'
    );
  }

  factory LoginNavigateState.goMain() {
    return LoginNavigateState(
      nextPage: '/main'
    );
  }
}