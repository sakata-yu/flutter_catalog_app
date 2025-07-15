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

final List<CatalogItem> catalogItems = [
  CatalogItem(
    title: "#1 カウントアプリ",
    detail: "最小アーキテクチャの理解",
    route: const CountRoute(),
  ),
];
