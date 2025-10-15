import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/network/response/mock_message.dart';

part 'polling_state.freezed.dart';

@freezed
abstract class PollingState with _$PollingState {
  const factory PollingState({
    @Default(<MockMessage>[]) List<MockMessage> messages,
  }) = _PollingState;
}
