import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

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
import '../../features/catalog009//method_channel_page.dart';
import '../../features/catalog010/hero_animation_page.dart';
import '../../features/catalog010//view/hero_animation_detail_page.dart';
import '../../features/catalog011/animated_container_page.dart';
import '../../features/catalog012/animated_list_page.dart';
import '../../features/catalog013/animated_switcher_page.dart';
import '../../features/catalog014/shared_preferences_page.dart';
import '../../features/catalog014/view/shared_preferences_once_page.dart';
import '../../features/catalog014/view/shared_preferences_simple_page.dart';
import '../../features/catalog015/hive_page.dart';
import '../../features/catalog016/polling_page.dart';
import '../../features/catalog017/graph_page.dart';
import '../../features/catalog018/bluetooth_page.dart';

import '../../features/catalog101/tutorial_page.dart';
import '../../features/catalog102/responsive_page.dart';

import '../../features/catalog201/intent_page.dart';
import '../../features/catalog202/backkey_page.dart';

import '../../features/catalog301/cupertino_sample_page.dart';
import '../../features/catalog302/cupertino_scrollbar_page.dart';

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
  List<AutoRoute> get routes => <AutoRoute>[
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
        AutoRoute(page: TutorialRoute.page),
        AutoRoute(page: ResponsiveRoute.page),
        AutoRoute(page: IntentRoute.page),
        AutoRoute(page: BackkeyRoute.page),
        AutoRoute(page: CupertinoSampleRoute.page),
        AutoRoute(page: CupertinoScrollbarRoute.page),
        AutoRoute(page: MethodChannelRoute.page),
        AutoRoute(page: HeroAnimationRoute.page),
        AutoRoute(page: HeroAnimationDetailRoute.page),
        AutoRoute(page: AnimatedContainerRoute.page),
        AutoRoute(page: AnimatedListRoute.page),
        AutoRoute(page: AnimatedSwitcherRoute.page),
        AutoRoute(page: SharedPreferencesRoute.page),
        AutoRoute(page: SharedPreferencesSimpleRoute.page),
        AutoRoute(page: SharedPreferencesOnceRoute.page),
        AutoRoute(page: HiveRoute.page),
        AutoRoute(page: PollingRoute.page),
        AutoRoute(page: GraphRoute.page),
        AutoRoute(page: BluetoothRoute.page),

        /// #008 画面遷移画面用
        AutoRoute(page: TransitionSimpleRoute.page),
        AutoRoute(
          page: TransitionTabsShellRoute.page,
          children: <AutoRoute>[
            AutoRoute(page: TransitionHomeRoute.page),
            AutoRoute(page: TransitionNoticeRoute.page),
            AutoRoute(page: TransitionMyRoute.page),
          ],
        ),
        AutoRoute(
          page: TransitionDrawerRoute.page,
          children: <AutoRoute>[
            AutoRoute(page: TransitionHomeRoute.page, path: ''),
            AutoRoute(page: TransitionNoticeRoute.page),
            AutoRoute(page: TransitionMyRoute.page),
          ],
        ),
      ];
}
