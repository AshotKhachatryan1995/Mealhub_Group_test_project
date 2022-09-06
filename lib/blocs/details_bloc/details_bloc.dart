import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealhub_group_test_project/middleware/models/photo.dart';

import '../../middleware/models/api_error_model.dart';
import '../../middleware/models/user.dart';
import '../../middleware/repositories/api_repository_impl.dart';
import 'details_event.dart';
import 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  DetailsBloc(this._apiRepositoryImpl) : super(InitialState()) {
    on<LoadUserEvent>(_onLoadUserEvent);
    on<LoadPhotosEvent>(_onLoadPhotosEvent);
    on<SaveDetailsEvent>(_onSaveDetailsEvent);
  }

  final ApiRepositoryImpl _apiRepositoryImpl;

  Future<void> _onLoadUserEvent(
      LoadUserEvent event, Emitter<DetailsState> emit) async {
    emit(LoadingState());
    final result = await _apiRepositoryImpl.getUser();

    if (result is ApiErrorModel) {
      emit(UserNotLoadedState());

      throw Exception(
          'Message is ${result.errorMessage} and code is ${result.errorCode}');
    }

    if (result is User) {
      emit(UserLoadedState(user: result));
    }
  }

  Future<void> _onLoadPhotosEvent(
      LoadPhotosEvent event, Emitter<DetailsState> emit) async {
    emit(LoadingState());
    final result = await _apiRepositoryImpl.getPhotos();

    if (result is ApiErrorModel) {
      emit(PhotosNotLoadedState());
      throw Exception(
          'Message is ${result.errorMessage} and code is ${result.errorCode}');
    }

    if (result is List<Photo>) {
      emit(PhotosLoadedState(photos: result));
    }
  }

  Future<void> _onSaveDetailsEvent(
      SaveDetailsEvent event, Emitter<DetailsState> emit) async {
    emit(LoadingState());
    final result = await _apiRepositoryImpl.saveDetails(user: event.user);

    if (result is ApiErrorModel) {
      emit(UserDataNotSavedState());
      throw Exception(
          'Message is ${result.errorMessage} and code is ${result.errorCode}');
    }

    if (result is bool) {
      emit(UserDetailsSavedState());
    }
  }
}
