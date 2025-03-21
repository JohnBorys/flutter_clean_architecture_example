import 'package:flutter_clean_architecture_example/core/usecases/usecases.dart';
import 'package:flutter_clean_architecture_example/core/utils/typedef.dart';
import 'package:flutter_clean_architecture_example/src/features/users/domain/entity/user.dart';
import 'package:flutter_clean_architecture_example/src/features/users/domain/repositories/users_repository.dart';

class GetUsers extends UsecasesWithoutParams<List<User>> {
  GetUsers({required UsersRepository repository}) : _repository = repository;

  final UsersRepository _repository;

  @override
  FutureResult<List<User>> call() async => _repository.getUsers();
}
