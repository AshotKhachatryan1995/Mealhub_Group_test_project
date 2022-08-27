import 'package:mealhub_group_test_project/blocs/navigation_bloc/navigation_event.dart';
import 'package:mealhub_group_test_project/blocs/navigation_bloc/navigation_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(InitialState()) {
    on<AppStartedEvent>(_onAppStartedEvent);
  }

  Future<void> _onAppStartedEvent(
      AppStartedEvent event, Emitter<NavigationState> emit) async {
    emit(LoadingState());
    emit(AuthenticatedState());
  }
}
