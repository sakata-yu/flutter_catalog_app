import 'package:catalog_app_flutter/core/network/mock_api_client.dart';
import 'package:catalog_app_flutter/features/catalog016/data/polling_manager.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../core/network/response/mock_message.dart';
import '../data/polling_state.dart';

final StateNotifierProvider<PollingViewModel, PollingState>
    pollingViewModelProvider =
    StateNotifierProvider<PollingViewModel, PollingState>(
        (Ref ref) => PollingViewModel(ref.read(mockChatApiProvider)));

class PollingViewModel extends StateNotifier<PollingState> {
  PollingViewModel(
    this.mockChatApi,
  ) : super(const PollingState());

  final MockChatApi mockChatApi;
  late PollingManager pollingManager;

  void startPolling() {
    pollingManager = PollingManager(
      callback: () async {
        final List<MockMessage> messages = await mockChatApi.fetchMessages();
        state = state.copyWith(messages: messages);
      },
      intervalSeconds: 2,
    );
    pollingManager.startPolling();
  }

  void stopPolling() {
    pollingManager.stopPolling();
  }
}
