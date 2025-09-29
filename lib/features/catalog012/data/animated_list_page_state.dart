import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'animated_list_page_state.freezed.dart';

@freezed
abstract class AnimatedListPageState with _$AnimatedListPageState {
  const factory AnimatedListPageState({
    GlobalKey<AnimatedListState>? listKey,
    @Default(<String>[]) List<String> items,
  }) = _AnimatedListPageState;

}
