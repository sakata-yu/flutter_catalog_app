import 'package:auto_route/auto_route.dart';

/**
 * ルーティング設定するページ一覧
 */
import '../../features/home/home_page.dart';
import '../../features/catalog001/count_page.dart';
import '../../features/catalog002/login_page.dart';
import '../../features/catalog003/sns_page.dart';
import '../../features/catalog004/custom_dialog_page.dart';
import '../../features/catalog005/camera_page.dart';
import '../../features/catalog005/view/take_picture_page.dart';
import '../../features/catalog006/map_page.dart';
import '../../features/catalog007/voice_page.dart';
import '../../features/catalog008/transition_page.dart';

/// #008 画面遷移画面用
import '../../features/catalog008/view/transition_simple_page.dart';
import '../../features/catalog008/view/transition_tabs_shell_page.dart';
import '../../features/catalog008/view/transition_home_page.dart';
import '../../features/catalog008/view/transition_notice_page.dart';
import '../../features/catalog008/view/transition_my_page.dart';
import '../../features/catalog008/view/transition_drawer_page.dart';

part 'app_router.gr.dart'; // 自動生成ファイル

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HomeRoute.page, initial: true),
        AutoRoute(page: CountRoute.page),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: SnsRoute.page),
        AutoRoute(page: CustomDialogRoute.page),
        AutoRoute(page: CameraRoute.page),
        AutoRoute(page: TakePictureRoute.page),
        AutoRoute(page: MapRoute.page),
        AutoRoute(page: VoiceRoute.page),
        AutoRoute(page: TransitionRoute.page),

        /// #008 画面遷移画面用
        AutoRoute(page: TransitionSimpleRoute.page),
        AutoRoute(
          page: TransitionTabsShellRoute.page,
          children: [
            AutoRoute(page: TransitionHomeRoute.page),
            AutoRoute(page: TransitionNoticeRoute.page),
            AutoRoute(page: TransitionMyRoute.page),
          ],
        ),
        AutoRoute(
          page: TransitionDrawerRoute.page,
          children: [
            AutoRoute(page: TransitionHomeRoute.page, path: ''),
            AutoRoute(page: TransitionNoticeRoute.page),
            AutoRoute(page: TransitionMyRoute.page),
          ],
        ),
      ];
}
