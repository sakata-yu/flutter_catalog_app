import 'dart:math';

import 'package:catarog_app_flutter/core/config/app_constants.dart';
import 'package:catarog_app_flutter/core/network/response/comment_response.dart';
import 'package:flutter/material.dart';

class CommentItem extends StatelessWidget {
  const CommentItem({
    super.key,
    required this.comment,
  });

  final CommentResponse comment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsGeometry.only(left: 32),
      child: ListTile(
        title: const Row(
          children: <Widget>[
            Icon(Icons.ac_unit),
            SizedBox(width: 4),
            Text(
              'hogehoge',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
        subtitle: Text(
          comment.body,
          style: const TextStyle(fontSize: 10),
        ),
      ),
    );
  }
}
