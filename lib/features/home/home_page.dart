import 'package:auto_route/auto_route.dart';
import 'package:catarog_app_flutter/core/config/catalog_items.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Catalog')),
      body: ListView.separated(
        itemBuilder: (content, index) {
          final item = catalogItems[index];
          return Card(
            elevation: 2,
            child: ListTile(
              leading: Icon(Icons.calculate),
              title: Text(item.title),
              subtitle: Text(item.detail),
              onTap: () => context.router.push(item.route),
            ),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(height: 5),
        itemCount: catalogItems.length,
      ),
    );
  }
}
