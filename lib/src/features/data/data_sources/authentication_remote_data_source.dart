import 'package:flutter_clean_architecture_example/src/features/data/models/user_model.dart';

abstract class AuthenticationRemoteDataSource {
  Future<void> createUser({
    required final String createdAt,
    required final String name,
    required final String avatar,
  });

  Future<List<UserModel>> getUsers();
}
