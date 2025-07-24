import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_request.freezed.dart';

part 'post_request.g.dart';

@freezed
abstract class PostRequest with _$PostRequest {
  const factory PostRequest({
    required int userId,
    required String title,
    required String body,
  }) = _PostRequest;

  factory PostRequest.fromJson(Map<String, dynamic> json) =>
      _$PostRequestFromJson(json);
}
