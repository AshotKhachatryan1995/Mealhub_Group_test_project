import 'package:equatable/equatable.dart';

import '../../middleware/models/photo.dart';
import '../../middleware/models/user.dart';

abstract class DetailsState extends Equatable {
  const DetailsState();

  @override
  List<Object> get props => [];
}

class InitialState extends DetailsState {
  @override
  List<Object> get props => [];
}

class LoadingState extends DetailsState {
  @override
  List<Object> get props => [];
}

class UserNotLoadedState extends DetailsState {
  @override
  List<Object> get props => [];
}

class UserLoadedState extends DetailsState {
  const UserLoadedState({required this.user, required this.photos});
  final User user;
  final List<Photo> photos;

  @override
  List<Object> get props => [user, photos];
}

class UserDetailsSavedState extends DetailsState {
  @override
  List<Object> get props => [];
}

class UserDataNotSavedState extends DetailsState {
  @override
  List<Object> get props => [];
}

class PhotosNotLoadedState extends DetailsState {
  @override
  List<Object> get props => [];
}
