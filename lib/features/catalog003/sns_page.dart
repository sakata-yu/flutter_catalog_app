import 'package:catarog_app_flutter/features/catalog003/view/post_item.dart';
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
    final state = ref.watch(snsViewModelProvider);
    final viewModel = ref.watch(snsViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('SNS')),
      body: switch (state) {
        AsyncLoading() => const Center(child: CircularProgressIndicator()),
        AsyncError(:final error) => Center(child: Text(error.toString())),
        AsyncValue(:final value) => RefreshIndicator(
            child: ListView.builder(
              itemCount: value?.posts.length,
              itemBuilder: (context, index) {
                final post = value?.posts[index];
                final comments = value?.commentsByPost[post?.id];
                if (post == null) return SizedBox.shrink();
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: InkWell(
                    onTap: () {
                      viewModel.selectPost(index);
                    },
                    child: PostItem(
                      post: post,
                      comments: comments ?? [],
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
          final result = await showDialog(
              context: context, builder: (context) => InputPostDialog());
          final isPostCreated =
              await viewModel.createPost(result['title'], result['body']);
          final snackBar = SnackBar(
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
