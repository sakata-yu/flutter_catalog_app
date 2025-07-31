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

  /// 概要: ログイン処理（仮）
  Future<void> login() async {
    state = AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await Future.delayed(const Duration(seconds: 2));
      authController.login();
      return state.value?.copyWith() ?? LoginState();
    });
  }

  /// 概要: ログアウト処理（仮）
  Future<void> logout() async {
    state = AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await Future.delayed(const Duration(seconds: 1));
      authController.logout();
      return state.value?.copyWith() ?? LoginState();
    });
  }

  /// 概要: 入力されたメールアドレスをStateに保存する関数
  ///
  /// Parameters:
  /// - [email] 説明: 入力されたemail
  ///
  void updateEmail(String email) {
    final currentState = state.value ?? const LoginState();
    state = AsyncValue.data(currentState.copyWith(email: email));
  }

  /// 概要: 入力されたパスワードをStateに保存する関数
  ///
  /// Parameters:
  /// - [password]] 説明: 入力されたpassword
  ///
  void updatePassword(String password) {
    final currentState = state.value ?? const LoginState();
    state = AsyncValue.data(currentState.copyWith(password: password));
  }
}
