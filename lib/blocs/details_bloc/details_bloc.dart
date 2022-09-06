import 'package:flutter_bloc/flutter_bloc.dart';

import '../../middleware/models/api_error_model.dart';
import '../../middleware/models/user.dart';
import '../../middleware/repositories/api_repository_impl.dart';
import 'details_event.dart';
import 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  DetailsBloc(this._apiRepositoryImpl) : super(InitialState()) {
    on<LoadUserEvent>(_onLoadUserEvent);
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
}
