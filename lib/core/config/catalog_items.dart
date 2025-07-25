import 'package:auto_route/auto_route.dart';
import 'package:catarog_app_flutter/core/router/app_router.dart';

class CatalogItem {
  final String title;
  final String detail;
  final PageRouteInfo route;

  const CatalogItem({
    required this.title,
    required this.detail,
    required this.route,
  });
}

class CatalogItems {
  static const common = [
    CatalogItem(
      title: "#1 カウントアプリ",
      detail: "最小アーキテクチャ実装",
      route: CountRoute(),
    ),
    CatalogItem(
      title: "#2 ログイン画面",
      detail: "フォームバリデーション実装",
      route: LoginRoute(),
    ),
    CatalogItem(
      title: "#3 SNS風画面",
      detail: "JSONPlaceholderを使った基本的なAPI実装",
      route: SnsRoute(),
    ),
    CatalogItem(
      title: "#4 カスタムダイアログ",
      detail: "AlertDialog・showModalBottomSheet",
      route: CountRoute(),
    ),
    CatalogItem(
      title: "#5 権限を使用する機能",
      detail: "両OSでの権限取得の実装",
      route: CountRoute(),
    ),
  ];

  static const ui = [
    CatalogItem(
      title: "#1 チュートリアル画面",
      detail: "Lottieを使ったアニメーション",
      route: CountRoute(),
    ),
    CatalogItem(
      title: "#2 レスポンシブUI",
      detail: "LayoutBuilder・MediaQuery",
      route: CountRoute(),
    ),
    CatalogItem(
      title: "#3 タブ・ナビゲーションバー",
      detail: "BottomNavigationBar・TabBarView",
      route: CountRoute(),
    ),
  ];

  static const android = [
    CatalogItem(
      title: "#1 インテントの起動",
      detail: "他アプリとの連携",
      route: CountRoute(),
    ),
    CatalogItem(
      title: "#2 バックキー検出",
      detail: "WillPopScope・SystemNavigator.pop制御",
      route: CountRoute(),
    ),
    CatalogItem(
      title: "#3 システムバー制御",
      detail: "ステータスバー透過・色変更",
      route: CountRoute(),
    ),
  ];

  static const ios = [
    CatalogItem(
      title: "#1 Cupertino UI",
      detail: "CupertinoButton・CupertinoAlertDialog",
      route: CountRoute(),
    ),
    CatalogItem(
      title: "#2 iOS風のスクロール挙動",
      detail: "CupertinoScrollbar・BouncingScrollPhysics",
      route: CountRoute(),
    ),
    CatalogItem(
      title: "#3 SafeAreaの使い方",
      detail: "ノッチ対応",
      route: CountRoute(),
    ),
  ];
}
