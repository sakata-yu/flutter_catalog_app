import 'dart:math';

import 'package:catarog_app_flutter/core/network/response/comment_response.dart';
import 'package:flutter/material.dart';

import '../../../core/config/app_constants.dart';
import '../../../core/network/response/post_response.dart';
import 'comment_item.dart';

class PostItem extends StatelessWidget {
  const PostItem({
    super.key,
    required this.post,
    required this.comments,
    required this.isSelected,
  });

  final PostResponse post;
  final List<CommentResponse> comments;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: Column(
          children: <Widget>[
            const Row(
              children: <Widget>[
                SizedBox(width: 8),
                CircleAvatar(
                  child: Icon(Icons.ac_unit),
                ),
                SizedBox(width: 8),
                Text('hogehoge')
              ],
            ),
            ListTile(
              title: Text(post.title),
              subtitle: Text(post.body),
            ),
            if (comments.isNotEmpty)
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                child: isSelected
                    ? ListView.builder(
                        itemCount: comments.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          final CommentResponse comment = comments[index];
                          return CommentItem(comment: comment);
                        })
                    : const SizedBox.shrink(),
              ),
          ],
        ),
      ),
    );
  }
}
