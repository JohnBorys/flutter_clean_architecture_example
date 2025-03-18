import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_example/core/error/exceptions.dart';
import 'package:flutter_clean_architecture_example/core/error/failure.dart';
import 'package:flutter_clean_architecture_example/core/utils/typedef.dart';
import 'package:flutter_clean_architecture_example/src/features/users/data/data_sources/users_remote_data_source.dart';
import 'package:flutter_clean_architecture_example/src/features/users/domain/entity/user.dart';
import 'package:flutter_clean_architecture_example/src/features/users/domain/repositories/users_repository.dart';

base class UsersRepositoryImpl extends UsersRepository {
  const UsersRepositoryImpl({
    required UsersRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  final UsersRemoteDataSource _remoteDataSource;

  @override
  ResultVoid createUser({
    required String createdAt,
    required String name,
    required String avatar,
  }) async {
    try {
      await _remoteDataSource.createUser(
        createdAt: createdAt,
        name: name,
        avatar: avatar,
      );
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
