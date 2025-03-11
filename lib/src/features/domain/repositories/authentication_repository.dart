import 'package:flutter_clean_architecture_example/src/core/utils/typedef.dart';
import 'package:flutter_clean_architecture_example/src/features/domain/entity/user.dart';

abstract class AuthenticationRepository {
  const AuthenticationRepository();

  ResultVoid createUser({
    required final String createdAt,
    required final String name,
    required final String avatar,
  });
  FutureResult<List<User>> getUsers();
}
