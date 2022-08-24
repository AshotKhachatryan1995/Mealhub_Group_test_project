import 'package:Mealhub_Group_test_project/blocs/home_bloc/home_event.dart';
import 'package:Mealhub_Group_test_project/blocs/home_bloc/home_state.dart';
import 'package:Mealhub_Group_test_project/middleware/repositories/api_repository_impl.dart';
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
  }
}
