import 'dart:async';
import 'dart:math';

import 'package:catarog_app_flutter/core/network/request/post_request.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../core/network/api_client.dart';
import '../data/sns_state.dart';

final snsViewModelProvider =
    AsyncNotifierProvider<SnsViewModel, SnsState>(() => SnsViewModel());

class SnsViewModel extends AsyncNotifier<SnsState> {
  SnsViewModel() : super();

  late final ApiClient apiClient;

  @override
  FutureOr<SnsState> build() async {
    apiClient = ref.watch(apiClientProvider);
    final result = await requestPosts();
    return result.value ?? SnsState();
  }

  Future<AsyncValue<SnsState>> requestPosts() {
    return AsyncValue.guard(() async {
      final posts = await apiClient.getPosts();
      return state.value?.copyWith(posts: posts) ?? SnsState(posts: posts);
    });
  }

  Future<void> refresh() async {
    state = state.copyWithPrevious(AsyncValue.loading());
    state = await requestPosts();
  }

  void selectPost(int index) async {
    final selectedPost = state.value?.selectedPostIndex;
    if (selectedPost == index) {
      state = AsyncValue.data(
          state.value?.copyWith(selectedPostIndex: -1) ?? SnsState());
    } else {
      state = state.copyWithPrevious(AsyncValue.loading());
      final selectedPostId = state.value?.posts[index].id;
      final isAlreadyFetched =
          state.value?.commentsByPost.containsKey(selectedPostId);
      if (selectedPostId == null) return;
      // すでにコメントデータがあるときはキャッシュから使用
      if (isAlreadyFetched == true) {
        state = AsyncValue.data(
            state.value?.copyWith(selectedPostIndex: index) ??
                SnsState(selectedPostIndex: index));
        return;
      }
      final commentsByPost = state.value?.commentsByPost ?? {};
      state = await AsyncValue.guard(() async {
        final comments = await apiClient.getComments(selectedPostId);
        return state.value?.copyWith(commentsByPost: {
              ...commentsByPost,
              selectedPostId: comments
            }) ??
            SnsState(
                commentsByPost: {...commentsByPost, selectedPostId: comments});
      });
    }
  }

  Future<bool> createPost(
    String title,
    String body,
  ) async {
    final userId = Random().nextInt(10000);
    final request = PostRequest(
      userId: userId,
      title: title,
      body: body,
    );
    final result = await AsyncValue.guard(() async {
      return await apiClient.createPost(request);
    });
    switch (result) {
      case AsyncLoading():
      case AsyncError():
        return false;
      case AsyncValue():
        return true;
    }
  }
}
