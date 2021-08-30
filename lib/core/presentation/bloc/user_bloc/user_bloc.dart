import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:epicture/core/domain/entities/user_entity.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitialState());

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is FetchUserInformationsEvent) {
      yield UserLoadedState(user: event.user);
    }
  }
}
