import 'package:mealhub_group_test_project/blocs/home_bloc/home_event.dart';
import 'package:mealhub_group_test_project/blocs/home_bloc/home_state.dart';
import 'package:mealhub_group_test_project/middleware/models/api_error_model.dart';
import 'package:mealhub_group_test_project/middleware/models/post.dart';
import 'package:mealhub_group_test_project/middleware/repositories/api_repository_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._apiRepositoryImpl) : super(InitialState()) {
    on<LoadPostsEvent>(_loadPostsEvent);
  }

  final ApiRepositoryImpl _apiRepositoryImpl;

  Future<void> _loadPostsEvent(
      LoadPostsEvent event, Emitter<HomeState> emit) async {
    emit(LoadingState());
    final result = await _apiRepositoryImpl.getPosts();

    if (result is ApiErrorModel) {
      emit(PostsNotLoadedState());

      throw Exception(
          'Message is ${result.errorMessage} and code is ${result.errorCode}');
    }

    if (result is List<Post>) {
      emit(PostsLoadedState(posts: result));
    }
  }
}
