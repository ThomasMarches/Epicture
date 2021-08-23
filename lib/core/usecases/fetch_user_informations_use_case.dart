import 'package:dartz/dartz.dart';
import 'package:epicture/core/data/sources/webview_data_source.dart';
import 'package:epicture/core/domain/entities/user_entity.dart';
import 'package:epicture/core/error/failure.dart';
import 'package:epicture/core/usecases/usecase.dart';

class FetchUserInformationsUseCase extends UseCase<UserEntity, NoParams> {
  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) async {
    final userInformations = await WebViewDataSource.fetchUserInformations();

    return (userInformations != null) ? Right(UserEntity(
      accessToken: userInformations.accessToken,
      accountId: userInformations.accountId,
      accountUsername: userInformations.accountUsername,
      refreshToken: userInformations.refreshToken,
      )) : const Left(ServerFailure());
  }
}
