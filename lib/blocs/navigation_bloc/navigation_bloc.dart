import 'package:flutter_bloc/flutter_bloc.dart';

import 'navigation_event.dart';
import 'navigation_state.dart';

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
