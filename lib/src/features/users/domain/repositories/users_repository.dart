import 'package:flutter_clean_architecture_example/core/utils/typedef.dart';
import 'package:flutter_clean_architecture_example/src/features/users/domain/entity/user.dart';

abstract class UsersRepository {
  const UsersRepository();

  ResultVoid createUser({
    required final String createdAt,
    required final String name,
    required final String avatar,
  });
  FutureResult<List<User>> getUsers();
}
