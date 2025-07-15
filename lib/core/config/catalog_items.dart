import 'package:auto_route/auto_route.dart';
import 'package:catarog_app_flutter/core/router/app_router.dart';

class CatalogItem {
  final String title;
  final PageRouteInfo route;

  const CatalogItem({required this.title, required this.route});
}

final List<CatalogItem> catalogItems = [
  CatalogItem(title: "カウントアプリ", route: const CountRoute()),
];
