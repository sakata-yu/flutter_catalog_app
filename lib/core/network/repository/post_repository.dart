import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../api_client.dart';
import '../request/post_request.dart';
import '../response/comment_response.dart';
import '../response/post_response.dart';

final Provider<PostRepository> postRepositoryProvider =
    Provider<PostRepository>((Ref ref) {
  return PostRepository(ref.watch(apiClientProvider));
});

class PostRepository {
  PostRepository(this.apiClient);

  final ApiClient apiClient;

  Future<List<PostResponse>> getPosts() => apiClient.getPosts();

  Future<PostResponse> createPost(PostRequest request) =>
      apiClient.createPost(request);

  Future<List<CommentResponse>> getComments(int id) =>
      apiClient.getComments(id);
}
