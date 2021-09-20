part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class FetchUserInformationsEvent extends UserEvent {
  const FetchUserInformationsEvent({required this.user});

  final UserEntity user;

  @override
  List<Object> get props => [user];
}
