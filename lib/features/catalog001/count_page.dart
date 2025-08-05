import 'package:catarog_app_flutter/features/catalog001/data/count_state.dart';
import 'package:catarog_app_flutter/features/catalog001/view/counter_text.dart';
import 'package:catarog_app_flutter/features/catalog001/view_model/count_view_model.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class CountPage extends HookConsumerWidget {
  const CountPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final CountState state = ref.watch(countViewModelProvider);
    final CountViewModel viewModel = ref.read(countViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('#1 カウントアプリ'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CounterText(count: state.count),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () => viewModel.increment(),
                child: const Icon(Icons.add),
              ),
              ElevatedButton(
                onPressed: () => viewModel.decrement(),
                child: const Icon(Icons.remove),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () => viewModel.reset(),
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }
}
