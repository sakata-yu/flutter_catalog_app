import 'package:catalog_app_flutter/features/catalog002/data/auth_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final StateNotifierProvider<AuthStateNotifier, AuthState> authProvider =
    StateNotifierProvider<AuthStateNotifier, AuthState>(
        (Ref ref) => AuthStateNotifier());

/// ログイン状態を管理するためのNotifier
/// アプリ全体で使用するため切り分け
class AuthStateNotifier extends StateNotifier<AuthState> {
  AuthStateNotifier() : super(const AuthState());

  void login() => state = state.copyWith(isLoggedIn: true);

  void logout() => state = state.copyWith(isLoggedIn: false);
}
