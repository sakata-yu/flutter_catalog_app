import 'package:auto_route/auto_route.dart';

/**
 * ルーティング設定するページ一覧
 */
import '../../features/home/home_page.dart';
import '../../features/catalog001/count_page.dart';
import '../../features/catalog002/login_page.dart';

part 'app_router.gr.dart'; // 自動生成ファイル

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HomeRoute.page, initial: true),
        AutoRoute(page: CountRoute.page),
        AutoRoute(page: LoginRoute.page),
      ];
}
