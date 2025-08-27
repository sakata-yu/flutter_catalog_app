import 'package:flutter/material.dart';

// ウィジェットテスト用のウィジェットキー
typedef WidgetKey = Key;

/// アプリ全体で共通して使用される定数を管理するクラス
class AppConstants {
  // ---------------- UI 関連 ----------------
  /// 基本padding
  static const double defaultPadding = 16.0;

  /// 基本margin
  static const double defaultMargin = 16.0;

  /// 共通で使用する角丸の半径
  static const double borderRadius = 8.0;

  /// ボタンの標準高さ
  static const double buttonHeight = 48.0;

  // ---------------- アニメーション・時間 ----------------
  /// 標準アニメーションの継続時間
  static const Duration animationDuration = Duration(milliseconds: 300);

  /// Snackbar の表示時間
  static const Duration snackbarDuration = Duration(seconds: 3);

  // ---------------- API・ネットワーク ----------------
  /// APIタイムアウト時間（秒）
  static const int apiTimeoutSeconds = 30;

  /// APIのベースURL
  static const String baseUrl = 'https://api.example.com';

  // ---------------- 入力制限 ----------------
  /// ユーザー名の最大文字数
  static const int maxUsernameLength = 20;

  /// パスコードの桁数
  static const int passcodeLength = 4;

  // ---------------- 識別子・キー ----------------
  /// SharedPreferences に保存するユーザー情報のキー
  static const String sharedPrefUserKey = 'user_info';

  /// アイコン一覧
  static const List<IconData> iconList = <IconData>[
    Icons.ac_unit,
    Icons.access_alarm,
    Icons.accessibility,
    Icons.account_balance,
    Icons.add_shopping_cart,
    Icons.airplanemode_active,
    Icons.anchor,
    Icons.android,
    Icons.auto_awesome,
    Icons.beach_access,
    Icons.cake,
    Icons.dashboard,
  ];

  static const WidgetKey countValueText = Key('count_value');
  static const WidgetKey countIncrementButton = Key('count_increment');
  static const WidgetKey countDecrementButton = Key('count_decrement');
  static const WidgetKey countResetButton = Key('count_reset');
}
