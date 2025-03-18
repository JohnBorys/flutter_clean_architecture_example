import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture_example/core/usecases/usecases.dart';
import 'package:flutter_clean_architecture_example/core/utils/typedef.dart';
import 'package:flutter_clean_architecture_example/src/features/users/domain/repositories/users_repository.dart';

class CreateUser implements UsecasesWithParams<void, CreateUserParams> {
  const CreateUser({required UsersRepository repository})
      : _repository = repository;

  final UsersRepository _repository;

  ResultVoid createUser({
    required String createdAt,
    required String name,
    required String avatar,
  }) async =>
      _repository.createUser(
        createdAt: createdAt,
        name: name,
        avatar: avatar,
      );

  @override
  FutureResult<void> call(CreateUserParams params) async =>
      _repository.createUser(
        createdAt: params.createdAt,
        name: params.name,
        avatar: params.avatar,
      );
}

class CreateUserParams extends Equatable {
  const CreateUserParams({
    required this.createdAt,
    required this.name,
    required this.avatar,
  });

  const CreateUserParams.empty() : this(createdAt: '', name: '', avatar: '');

  final String createdAt;
  final String name;
  final String avatar;

  @override
  List<Object?> get props => [createdAt, name, avatar];
}
