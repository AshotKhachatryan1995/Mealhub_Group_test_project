import 'package:mealhub_group_test_project/middleware/models/post.dart';
import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class InitialState extends HomeState {
  @override
  List<Object> get props => [];
}

class LoadingState extends HomeState {
  @override
  List<Object> get props => [];
}

class PostsNotLoadedState extends HomeState {
  @override
  List<Object> get props => [];
}

class PostsLoadedState extends HomeState {
  const PostsLoadedState({required this.posts});
  final List<Post> posts;

  @override
  List<Object> get props => [posts];
}
