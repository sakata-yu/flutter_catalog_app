import 'package:catarog_app_flutter/features/catalog002/data/auth_state_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../data/login_state.dart';

final loginViewModelProvider =
    StateNotifierProvider<LoginViewModel, AsyncValue<LoginState>>(
        (ref) => LoginViewModel(ref));

class LoginViewModel extends StateNotifier<AsyncValue<LoginState>> {
  LoginViewModel(this.ref) : super(const AsyncValue.data(LoginState())) {
    authController = ref.read(authProvider.notifier);
  }

  final Ref ref;
  late final AuthStateNotifier authController;

  Future<void> login() async {
    state = AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await Future.delayed(const Duration(seconds: 2));
      authController.login();
      return state.value?.copyWith() ?? LoginState();
    });
  }

  Future<void> logout() async {
    state = AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await Future.delayed(const Duration(seconds: 1));
      authController.logout();
      return state.value?.copyWith() ?? LoginState();
    });
  }

  void updateEmail(String email) {
    final currentState = state.value ?? const LoginState();
    state = AsyncValue.data(currentState.copyWith(email: email));
  }

  void updatePassword(String password) {
    final currentState = state.value ?? const LoginState();
    state = AsyncValue.data(currentState.copyWith(password: password));
  }
}
