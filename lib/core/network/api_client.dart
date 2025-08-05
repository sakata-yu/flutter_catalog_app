import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:retrofit/retrofit.dart';

import 'request/post_request.dart';
import 'response/comment_response.dart';
import 'response/post_response.dart';

part 'api_client.g.dart';

final Provider<ApiClient> apiClientProvider =
    Provider<ApiClient>((Ref<ApiClient> ref) {
  return ApiClient(Dio(_dioOption));
});

final BaseOptions _dioOption = BaseOptions(
  baseUrl: 'https://jsonplaceholder.typicode.com',
  contentType: 'application/json',
);

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio) = _ApiClient;

  @GET('/posts')
  Future<List<PostResponse>> getPosts();

  @POST('/posts')
  Future<PostResponse> createPost(@Body() PostRequest request);

  @GET('/posts/{id}/comments')
  Future<List<CommentResponse>> getComments(@Path() int id);
}
