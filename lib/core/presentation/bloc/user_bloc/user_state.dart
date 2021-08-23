part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitialState extends UserState {}

class UserLoadedState extends UserState {
  const UserLoadedState({required this.user});

  final UserEntity user;

  @override
  List<Object> get props => [user];
}

class UserLoadingFailureState extends UserState {}
