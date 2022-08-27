import 'package:mealhub_group_test_project/blocs/details_bloc/details_event.dart';
import 'package:mealhub_group_test_project/blocs/details_bloc/details_state.dart';
import 'package:mealhub_group_test_project/middleware/models/api_error_model.dart';
import 'package:mealhub_group_test_project/middleware/models/user.dart';
import 'package:mealhub_group_test_project/middleware/repositories/api_repository_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
