import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure([List properties = const <dynamic>[]]) : _args = properties;

  final List _args;

  @override
  List<Object?> get props => _args;

  String toMessage() {
    switch (runtimeType) {
      case ServerFailure:
        return (this as ServerFailure).message ?? 'Server failure';
      case CacheFailure:
        return (this as CacheFailure).message ?? 'Cache Failure';
      default:
        return 'Unexpected error';
    }
  }
}

class ServerFailure extends Failure {
  const ServerFailure({this.message});

  final String? message;

  @override
  List<Object?> get props => [message];
}

class CacheFailure extends Failure {
  const CacheFailure({this.message});

  final String? message;

  @override
  List<Object?> get props => [message];
}

class PermissionFailure extends Failure {
  const PermissionFailure({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
