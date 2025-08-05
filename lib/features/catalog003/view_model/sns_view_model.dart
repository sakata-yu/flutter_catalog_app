import 'dart:async';
import 'dart:math';

import 'package:catarog_app_flutter/core/network/request/post_request.dart';
import 'package:catarog_app_flutter/core/network/response/comment_response.dart';
import 'package:catarog_app_flutter/core/network/response/post_response.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../core/network/api_client.dart';
import '../data/sns_state.dart';

final AsyncNotifierProvider<SnsViewModel, SnsState> snsViewModelProvider =
    AsyncNotifierProvider<SnsViewModel, SnsState>(() => SnsViewModel());

class SnsViewModel extends AsyncNotifier<SnsState> {
  SnsViewModel() : super();

  late final ApiClient apiClient;

  /// 最初に呼ばれる関数、APIから投稿データを取得する
  ///
  /// Returns:
  /// - 説明: APIが成功すればAPI結果、失敗すれば空の初期値を入れる
  ///
  @override
  FutureOr<SnsState> build() async {
    apiClient = ref.watch(apiClientProvider);
    final AsyncValue<SnsState> result = await requestPosts();
    return result.value ?? const SnsState();
  }

  /// APIから投稿データを取得する関数
  ///
  /// Returns:
  /// - 説明: API結果をFutureで返す
  ///
  Future<AsyncValue<SnsState>> requestPosts() {
    return AsyncValue.guard(() async {
      final List<PostResponse> posts = await apiClient.getPosts();
      return state.value?.copyWith(posts: posts) ?? SnsState(posts: posts);
    });
  }

  /// 更新時に呼ばれる関数、APIから投稿データを取得する
  Future<void> refresh() async {
    state = state.copyWithPrevious(const AsyncValue<SnsState>.loading());
    state = await requestPosts();
  }

  /// 概要: 選択したポストのindexを保存し、コメント情報がなければAPIから取得する関数
  ///
  /// Parameters:
  /// - [index] 説明: 選択したポストのindex
  ///
  /// Returns:
  /// - 説明: 選択したポストのindex、それに対するコメント情報を保存する
  ///
  void selectPost(int index) async {
    final int? selectedPost = state.value?.selectedPostIndex;
    if (selectedPost == index) {
      state = AsyncValue<SnsState>.data(
          state.value?.copyWith(selectedPostIndex: -1) ?? const SnsState());
    } else {
      state = state.copyWithPrevious(const AsyncValue<SnsState>.loading());
      final int? selectedPostId = state.value?.posts[index].id;
      final bool? isAlreadyFetched =
          state.value?.commentsByPost.containsKey(selectedPostId);
      if (selectedPostId == null) return;
      // すでにコメントデータがあるときはキャッシュから使用
      if (isAlreadyFetched == true) {
        state = AsyncValue<SnsState>.data(
            state.value?.copyWith(selectedPostIndex: index) ??
                SnsState(selectedPostIndex: index));
        return;
      }
      final Map<int, List<CommentResponse>> commentsByPost =
          state.value?.commentsByPost ?? <int, List<CommentResponse>>{};
      state = await AsyncValue.guard(() async {
        final List<CommentResponse> comments =
            await apiClient.getComments(selectedPostId);
        return state.value?.copyWith(
                commentsByPost: <int, List<CommentResponse>>{
                  ...commentsByPost,
                  selectedPostId: comments
                }) ??
            SnsState(commentsByPost: <int, List<CommentResponse>>{
              ...commentsByPost,
              selectedPostId: comments
            });
      });
    }
  }

  /// ポストを投稿する関数
  ///
  /// Parameters:
  /// - [title] 説明: 投稿するタイトル
  /// - [body] 説明: 投稿する本文
  ///
  /// Returns:
  /// - 説明: 投稿が成功したかどうかの真偽
  ///
  Future<bool> createPost(
    String title,
    String body,
  ) async {
    final int userId = Random().nextInt(10000);
    final PostRequest request = PostRequest(
      userId: userId,
      title: title,
      body: body,
    );
    final AsyncValue<PostResponse> result = await AsyncValue.guard(() async {
      return await apiClient.createPost(request);
    });
    switch (result) {
      case AsyncLoading<PostResponse>():
      case AsyncError<PostResponse>():
        return false;
      case AsyncValue<PostResponse>():
        return true;
    }
  }
}
