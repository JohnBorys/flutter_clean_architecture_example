import 'package:flutter_clean_architecture_example/core/utils/typedef.dart';
import 'package:flutter_clean_architecture_example/src/features/users/domain/entity/user.dart';

abstract class UsersRepository {
  const UsersRepository();

  ResultVoid createUser({
    required String createdAt,
    required String name,
    required String avatar,
  });
  FutureResult<List<User>> getUsers();
}
