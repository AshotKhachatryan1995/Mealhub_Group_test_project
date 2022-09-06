import 'package:equatable/equatable.dart';

import '../../middleware/models/user.dart';

abstract class DetailsEvent extends Equatable {
  const DetailsEvent();

  @override
  List<Object> get props => [];
}

class InitialEvent extends DetailsEvent {
  @override
  List<Object> get props => [];
}

class LoadUserEvent extends DetailsEvent {
  @override
  List<Object> get props => [];
}

class LoadPhotosEvent extends DetailsEvent {
  @override
  List<Object> get props => [];
}

class SaveDetailsEvent extends DetailsEvent {
  const SaveDetailsEvent({required this.user});
  final User user;

  @override
  List<Object> get props => [];
}
