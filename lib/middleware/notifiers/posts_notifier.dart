import 'package:flutter/material.dart';

import '../models/post.dart';

class PostsNotifier extends ChangeNotifier {
  List<Post> _posts = [];
  List<Post> get posts => _posts;

  void loadPosts({required List<Post> posts}) {
    _posts = posts;
    notifyListeners();
  }
}
