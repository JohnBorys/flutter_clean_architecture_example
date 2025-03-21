import 'package:equatable/equatable.dart';

import 'package:flutter_clean_architecture_example/core/error/exceptions.dart';

abstract class Failure extends Equatable {
  const Failure({
    required this.message,
    required this.statusCode,
  });

  final String message;
  final int statusCode;

  String get errorMessage => 'Status Code: $statusCode Error: $message';

  @override
  List<Object?> get props => [message, statusCode];
}

class ApiFailure extends Failure {
  const ApiFailure({
    required super.message,
    required super.statusCode,
  });

  factory ApiFailure.fromException(ApiException exception) =>
      ApiFailure(message: exception.message, statusCode: exception.statusCode);
}

class ServerFailure extends Failure {
  const ServerFailure({
    required super.message,
    required super.statusCode,
  });
}
