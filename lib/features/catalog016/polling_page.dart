import 'package:catalog_app_flutter/features/catalog016/data/polling_state.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/network/response/mock_message.dart';
import 'view_model/polling_view_model.dart';

@RoutePage()
class PollingPage extends HookConsumerWidget {
  const PollingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PollingState state = ref.watch(pollingViewModelProvider);
    final PollingViewModel viewModel =
        ref.read(pollingViewModelProvider.notifier);

    useEffect(() {
      Future<void>.microtask(() {
        viewModel.startPolling();
      });

      return () {
        viewModel.stopPolling();
      };
    }, const <Object?>[]);

    return Scaffold(
      appBar: AppBar(title: const Text('polling')),
      body: state.messages.isNotEmpty
          ? ListView.builder(
              itemCount: state.messages.length,
              itemBuilder: (BuildContext context, int index) {
                final MockMessage message = state.messages[index];
                return ListTile(
                  title: Text(message.message),
                  subtitle: Text('${message.timestamp}'),
                );
              },
            )
          : const Center(
              child: Text('2秒後からメッセージが到着します'),
            ),
    );
  }
}
