import 'package:equatable/equatable.dart';

abstract class DetailsEvent extends Equatable {
  const DetailsEvent();

  @override
  List<Object?> get props => [];
}

class InitialEvent extends DetailsEvent {
  @override
  List<Object?> get props => [];
}

class LoadUserEvent extends DetailsEvent {
  @override
  List<Object?> get props => [];
}
