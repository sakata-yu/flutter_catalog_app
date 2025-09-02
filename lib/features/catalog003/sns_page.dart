import 'package:catalog_app_flutter/core/network/response/comment_response.dart';
import 'package:catalog_app_flutter/core/network/response/post_response.dart';
import 'package:catalog_app_flutter/features/catalog003/data/sns_state.dart';
import 'package:catalog_app_flutter/features/catalog003/view/post_item.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'view/input_post_dialog.dart';
import 'view_model/sns_view_model.dart';

@RoutePage()
class SnsPage extends HookConsumerWidget {
  const SnsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<SnsState> state = ref.watch(snsViewModelProvider);
    final SnsViewModel viewModel = ref.watch(snsViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('SNS')),
      body: switch (state) {
        AsyncLoading<SnsState>() =>
          const Center(child: CircularProgressIndicator()),
        AsyncError<SnsState>(:final Object error) =>
          Center(child: Text(error.toString())),
        AsyncValue<SnsState>(:final SnsState? value) => RefreshIndicator(
            child: ListView.builder(
              itemCount: value?.posts.length,
              itemBuilder: (BuildContext context, int index) {
                final PostResponse? post = value?.posts[index];
                final List<CommentResponse>? comments =
                    value?.commentsByPost[post?.id];
                if (post == null) return const SizedBox.shrink();
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: InkWell(
                    onTap: () {
                      viewModel.selectPost(index);
                    },
                    child: PostItem(
                      post: post,
                      comments: comments ?? <CommentResponse>[],
                      isSelected: index == value?.selectedPostIndex,
                    ),
                  ),
                );
              },
            ),
            onRefresh: () {
              return viewModel.refresh();
            },
          ),
      },
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final Map<String, String>? result = await showDialog(
              context: context,
              builder: (BuildContext context) => const InputPostDialog());
          if (result == null) return;
          final bool isPostCreated = await viewModel.createPost(
              result['title'] ?? '', result['body'] ?? '');
          final SnackBar snackBar = SnackBar(
            content: Text(isPostCreated ? '投稿しました' : '投稿に失敗しました'),
            backgroundColor: isPostCreated ? Colors.green : Colors.red,
          );

          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
