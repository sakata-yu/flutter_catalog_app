import 'package:auto_route/auto_route.dart';
import 'package:catarog_app_flutter/core/router/app_router.dart';

class CatalogItem {

  const CatalogItem({
    required this.title,
    required this.detail,
    required this.route,
  });
  final String title;
  final String detail;
  final PageRouteInfo route;
}

class CatalogItems {
  static const List<CatalogItem> common = <CatalogItem>[
    CatalogItem(
      title: '#001 カウントアプリ',
      detail: '最小アーキテクチャ実装',
      route: CountRoute(),
    ),
    CatalogItem(
      title: '#002 ログイン画面',
      detail: 'フォームバリデーション実装',
      route: LoginRoute(),
    ),
    CatalogItem(
      title: '#003 SNS風画面',
      detail: 'JSONPlaceholderを使った基本的なAPI実装',
      route: SnsRoute(),
    ),
    CatalogItem(
      title: '#004 ダイアログ系ウィジェット',
      detail: 'Snackbar・AlertDialog・BottomSheet・Toast',
      route: CustomDialogRoute(),
    ),
    CatalogItem(
      title: '#005 カメラ画面',
      detail: 'カメラを使った撮影機能の実装',
      route: CameraRoute(),
    ),
    CatalogItem(
      title: '#006 マップ画面',
      detail: 'FlutterMapを使用した位置情報の取得',
      route: MapRoute(),
    ),
    CatalogItem(
      title: '#007 音声入力',
      detail: '音声入力機能',
      route: VoiceRoute(),
    ),
    CatalogItem(
      title: '#008 画面遷移',
      detail: 'AutoRouteを使った画面遷移',
      route: TransitionRoute(),
    ),
  ];

  static const List<CatalogItem> ui = <CatalogItem>[
    CatalogItem(
      title: '#101 チュートリアル画面',
      detail: 'Lottieを使ったアニメーション',
      route: CountRoute(),
    ),
    CatalogItem(
      title: '#102 レスポンシブUI',
      detail: 'LayoutBuilder・MediaQuery',
      route: CountRoute(),
    ),
  ];

  static const List<CatalogItem> android = <CatalogItem>[
    CatalogItem(
      title: '#201 インテントの起動',
      detail: '他アプリとの連携',
      route: CountRoute(),
    ),
    CatalogItem(
      title: '#202 バックキー検出',
      detail: 'WillPopScope・SystemNavigator.pop制御',
      route: CountRoute(),
    ),
    CatalogItem(
      title: '#203 システムバー制御',
      detail: 'ステータスバー透過・色変更',
      route: CountRoute(),
    ),
  ];

  static const List<CatalogItem> ios = <CatalogItem>[
    CatalogItem(
      title: '#301 Cupertino UI',
      detail: 'CupertinoButton・CupertinoAlertDialog',
      route: CountRoute(),
    ),
    CatalogItem(
      title: '#302 iOS風のスクロール挙動',
      detail: 'CupertinoScrollbar・BouncingScrollPhysics',
      route: CountRoute(),
    ),
    CatalogItem(
      title: '#303 SafeAreaの使い方',
      detail: 'ノッチ対応',
      route: CountRoute(),
    ),
  ];
}
