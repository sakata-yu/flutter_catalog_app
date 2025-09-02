import 'package:auto_route/auto_route.dart';
import 'package:catalog_app_flutter/core/router/app_router.dart';
import 'package:catalog_app_flutter/core/utils/context_extension.dart';
import 'package:flutter/material.dart' hide TransitionRoute;

class CatalogItem {
  const CatalogItem({
    required this.title,
    required this.detail,
    required this.route,
  });

  final String Function(BuildContext context) title;
  final String Function(BuildContext context) detail;
  final PageRouteInfo route;

  String titleOf(BuildContext context) => title(context);

  String detailOf(BuildContext context) => detail(context);
}

List<CatalogItem> commonCatalogItems = <CatalogItem>[
  CatalogItem(
    title: (BuildContext context) => context.l10n.count_app_title,
    detail: (BuildContext context) => context.l10n.count_app_detail,
    route: const CountRoute(),
  ),
  CatalogItem(
    title: (BuildContext context) => context.l10n.login_title,
    detail: (BuildContext context) => context.l10n.login_detail,
    route: const LoginRoute(),
  ),
  CatalogItem(
    title: (BuildContext context) => context.l10n.sns_title,
    detail: (BuildContext context) => context.l10n.sns_detail,
    route: const SnsRoute(),
  ),
  CatalogItem(
    title: (BuildContext context) => context.l10n.dialog_title,
    detail: (BuildContext context) => context.l10n.dialog_detail,
    route: const CustomDialogRoute(),
  ),
  CatalogItem(
    title: (BuildContext context) => context.l10n.camera_title,
    detail: (BuildContext context) => context.l10n.camera_detail,
    route: const CameraRoute(),
  ),
  CatalogItem(
    title: (BuildContext context) => context.l10n.map_title,
    detail: (BuildContext context) => context.l10n.map_detail,
    route: const MapRoute(),
  ),
  CatalogItem(
    title: (BuildContext context) => context.l10n.voice_title,
    detail: (BuildContext context) => context.l10n.voice_detail,
    route: const VoiceRoute(),
  ),
  CatalogItem(
      title: (BuildContext context) => context.l10n.transition_title,
      detail: (BuildContext context) => context.l10n.transition_detail,
      route: const TransitionRoute()),
];

List<CatalogItem> uiCatalogItems = <CatalogItem>[
  CatalogItem(
    title: (BuildContext context) => context.l10n.tutorial_title,
    detail: (BuildContext context) => context.l10n.tutorial_detail,
    route: const TutorialRoute(),
  ),
  CatalogItem(
    title: (BuildContext context) => context.l10n.responsive_title,
    detail: (BuildContext context) => context.l10n.responsive_detail,
    route: const ResponsiveRoute(),
  ),
];

List<CatalogItem> androidCatalogItems = <CatalogItem>[
  CatalogItem(
    title: (BuildContext context) => context.l10n.intent_title,
    detail: (BuildContext context) => context.l10n.intent_detail,
    route: const IntentRoute(),
  ),
  CatalogItem(
    title: (BuildContext context) => context.l10n.backkey_title,
    detail: (BuildContext context) => context.l10n.backkey_detail,
    route: const BackkeyRoute(),
  ),
];

List<CatalogItem> iosCatalogItems = <CatalogItem>[
  CatalogItem(
    title: (BuildContext context) => context.l10n.cupertino_title,
    detail: (BuildContext context) => context.l10n.cupertino_detail,
    route: const CupertinoSampleRoute(),
  ),
  CatalogItem(
    title: (BuildContext context) => context.l10n.scroll_title,
    detail: (BuildContext context) => context.l10n.scroll_detail,
    route: const CupertinoScrollbarRoute(),
  ),
  CatalogItem(
    title: (BuildContext context) => context.l10n.safearea_title,
    detail: (BuildContext context) => context.l10n.safearea_detail,
    route: const CountRoute(),
  ),
];
