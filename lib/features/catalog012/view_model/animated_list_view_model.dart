import 'package:catalog_app_flutter/features/catalog012/data/animated_list_page_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final StateNotifierProvider<AnimatedListViewModel, AnimatedListPageState>
    animatedListViewModelProvider =
    StateNotifierProvider<AnimatedListViewModel, AnimatedListPageState>(
        (Ref ref) => AnimatedListViewModel());

class AnimatedListViewModel extends StateNotifier<AnimatedListPageState> {
  AnimatedListViewModel()
      : super(
          AnimatedListPageState(
            listKey: GlobalKey(),
            items: <String>[
              'Apple',
              'Banana',
              'Chocolate',
            ],
          ),
        );

  void addItem(String item) {
    final GlobalKey<AnimatedListState>? listKey = state.listKey;
    if (listKey == null) return;
    listKey.currentState?.insertItem(state.items.length);
    state = state.copyWith(
      items: <String>[...state.items, item],
      listKey: listKey,
    );
  }

  void removeItem(int index) {
    final GlobalKey<AnimatedListState>? listKey = state.listKey;
    if (listKey == null) return;
    final List<String> items = <String>[...state.items];
    final String removeItemTitle = items[index];
    items.removeAt(index);
    listKey.currentState?.removeItem(
      index,
      (BuildContext context, Animation<double> animation) {
        return SizeTransition(
          sizeFactor: animation,
          child: ListTile(
            title: Text(removeItemTitle),
          ),
        );
      },
      duration: const Duration(milliseconds: 300),
    );
    state = state.copyWith(
      items: items,
      listKey: listKey,
    );
  }
}
