import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:epicture/core/domain/entities/user_entity.dart';
import 'package:epicture/core/usecases/fetch_user_informations_use_case.dart';
import 'package:epicture/core/usecases/usecase.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc()
      :
        super(UserInitialState());

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is FetchUserInformationsEvent) {
      yield* _mapFetchUserInformationsToState();
    }
  }

  Stream<UserState> _mapFetchUserInformationsToState() async* {
    final usecase = FetchUserInformationsUseCase();
    final userEither = await usecase.call(NoParams());

    yield* userEither.fold(
      (failure) async* {
        yield UserLoadingFailureState();
      },
      (user) async* {
        yield UserLoadedState(user: user);
      },
    );
  }
}
