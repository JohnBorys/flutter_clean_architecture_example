import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_example/src/core/error/exceptions.dart';
import 'package:flutter_clean_architecture_example/src/core/error/failure.dart';
import 'package:flutter_clean_architecture_example/src/core/utils/typedef.dart';
import 'package:flutter_clean_architecture_example/src/features/data/data_sources/authentication_remote_data_source.dart';
import 'package:flutter_clean_architecture_example/src/features/domain/entity/user.dart';
import 'package:flutter_clean_architecture_example/src/features/domain/repositories/authentication_repository.dart';

base class AuthenticationRepositoryImpl extends AuthenticationRepository {
  const AuthenticationRepositoryImpl(
      {required final AuthenticationRemoteDataSource remoteDataSource})
      : _remoteDataSource = remoteDataSource;

  final AuthenticationRemoteDataSource _remoteDataSource;

  @override
  ResultVoid createUser({
    required String createdAt,
    required String name,
    required String avatar,
  }) async {
    try {
      await _remoteDataSource.createUser(
          createdAt: createdAt, name: name, avatar: avatar);
      return const Right(null);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  FutureResult<List<User>> getUsers() async {
    try {
      final result = await _remoteDataSource.getUsers();
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }
}
