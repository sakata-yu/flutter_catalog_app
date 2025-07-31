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

  /// 最初に呼ばれる関数、APIから投稿データを取得する
  ///
  /// Returns:
  /// - 説明: APIが成功すればAPI結果、失敗すれば空の初期値を入れる
  ///
  @override
  FutureOr<SnsState> build() async {
    apiClient = ref.watch(apiClientProvider);
    final result = await requestPosts();
    return result.value ?? SnsState();
  }

  /// APIから投稿データを取得する関数
  ///
  /// Returns:
  /// - 説明: API結果をFutureで返す
  ///
  Future<AsyncValue<SnsState>> requestPosts() {
    return AsyncValue.guard(() async {
      final posts = await apiClient.getPosts();
      return state.value?.copyWith(posts: posts) ?? SnsState(posts: posts);
    });
  }

  /// 更新時に呼ばれる関数、APIから投稿データを取得する
  Future<void> refresh() async {
    state = state.copyWithPrevious(AsyncValue.loading());
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
