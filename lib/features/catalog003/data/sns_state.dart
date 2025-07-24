import 'package:catarog_app_flutter/core/network/response/post_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/network/response/comment_response.dart';

part 'sns_state.freezed.dart';

@freezed
abstract class SnsState with _$SnsState {
  const factory SnsState({
    @Default([]) List<PostResponse> posts,
    @Default({}) Map<int, List<CommentResponse>> commentsByPost,
    @Default(-1) int selectedPostIndex,
  }) = _SnsState;
}
