import 'package:flutter_clean_architecture_example/src/core/usecases/usecases.dart';
import 'package:flutter_clean_architecture_example/src/core/utils/typedef.dart';
import 'package:flutter_clean_architecture_example/src/features/domain/entity/user.dart';
import 'package:flutter_clean_architecture_example/src/features/domain/repositories/authentication_repository.dart';

class GetUsers extends UsecasesWithoutParams<List<User>> {
  const GetUsers({required final AuthenticationRepository repository})
      : _repository = repository;

  final AuthenticationRepository _repository;

  @override
  FutureResult<List<User>> call() async => _repository.getUsers();
}
