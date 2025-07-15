import 'package:auto_route/auto_route.dart';
import 'package:catarog_app_flutter/core/config/catalog_items.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final sections = [
      {
        'title': '共通機能',
        'items': CatalogItems.common,
      },
      {
        'title': 'UI機能',
        'items': CatalogItems.ui,
      },
      {
        'title': 'Android専用機能',
        'items': CatalogItems.android,
      },
      {
        'title': 'iOS専用機能',
        'items': CatalogItems.ios,
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Catalog')),
      body: ListView.builder(
        itemCount: sections.fold<int>(
          0,
          (sum, section) => sum + 1 + (section['items'] as List).length,
        ),
        itemBuilder: (context, index) {
          int currentIndex = 0;

          for (final section in sections) {
            final title = section['title'] as String;
            final items = section['items'] as List<CatalogItem>;

            if (index == currentIndex) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Text(
                  title,
                ),
              );
            }

            currentIndex += 1;

            if (index < currentIndex + items.length) {
              final item = items[index - currentIndex];
              return ListTile(
                title: Text(item.title),
                subtitle: Text(item.detail),
                onTap: () => context.router.push(item.route),
              );
            }

            currentIndex += items.length;
          }

          return SizedBox.shrink();
        },
      ),
    );
  }
}
