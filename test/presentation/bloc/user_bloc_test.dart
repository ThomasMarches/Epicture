import 'package:bloc_test/bloc_test.dart';
import 'package:epicture/core/domain/entities/user_entity.dart';
import 'package:epicture/core/presentation/bloc/user_bloc/user_bloc.dart';

void main() {
  const user = UserEntity(
    accessToken: '',
    refreshToken: '',
    accountUsername: '',
    accountId: '',
  );

  blocTest(
    'emits [UserLoadedState] when FetchUserInformationsEvent is added',
    build: () => UserBloc(),
    act: (UserBloc bloc) =>
        bloc.add(const FetchUserInformationsEvent(user: user)),
    expect: () => [const UserLoadedState(user: user)],
  );
}
