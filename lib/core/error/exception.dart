class ServerException implements Exception {
  ServerException({this.message});

  final String? message;
}

class CacheException implements Exception {
  CacheException({this.message});

  final String? message;
}

class UserNotFoundException implements Exception {
  UserNotFoundException({this.message});

  final String? message;
}

class TicketNotFoundException implements Exception {
  TicketNotFoundException({this.message});

  final String? message;
}
