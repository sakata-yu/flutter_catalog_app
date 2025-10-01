import 'package:catalog_app_flutter/features/catalog012/data/animated_list_page_state.dart';
import 'package:flutter/material.dart' hide AnimatedListState;
import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'view_model/animated_list_view_model.dart';

@RoutePage()
class AnimatedListPage extends HookConsumerWidget {
  const AnimatedListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AnimatedListPageState state =
        ref.watch(animatedListViewModelProvider);
    final AnimatedListViewModel viewModel =
        ref.read(animatedListViewModelProvider.notifier);
    return Scaffold(
      appBar: AppBar(title: const Text('Animated List')),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => viewModel.addItem('Hello'),
      ),
      body: AnimatedList(
          key: state.listKey,
          initialItemCount: state.items.length,
          itemBuilder:
              (BuildContext context, int index, Animation<double> animation) {
            final String item = state.items[index];
            return SizeTransition(
              sizeFactor: animation,
              child: ListTile(
                title: Text(item),
                onTap: () => viewModel.removeItem(index),
              ),
            );
          }),
    );
  }
}
