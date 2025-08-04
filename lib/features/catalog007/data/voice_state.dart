import 'package:freezed_annotation/freezed_annotation.dart';

part 'voice_state.freezed.dart';

@freezed
abstract class VoiceState with _$VoiceState {
  const factory VoiceState({
    @Default("") String speechResult,
  }) = _VoiceState;
}
