import 'package:mealhub_group_test_project/middleware/models/post.dart';
import 'package:flutter/material.dart';

class PostsNotifier extends ChangeNotifier {
  List<Post> _posts = [];
  List<Post> get posts => _posts;

  void loadPosts({required List<Post> posts}) {
    _posts = posts;
    notifyListeners();
  }
}
