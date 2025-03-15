import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture_example/src/features/users/domain/entity/user.dart';
import 'package:flutter_clean_architecture_example/src/features/users/domain/usecases/create_user.dart';
import 'package:flutter_clean_architecture_example/src/features/users/domain/usecases/get_users.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  UsersCubit({
    required final CreateUser createUser,
    required final GetUsers getUsers,
  })  : _createUser = createUser,
        _getUsers = getUsers,
        super(UsersInitial());

  final CreateUser _createUser;
  final GetUsers _getUsers;

  Future<void> createUser({
    required final String createdAt,
    required final String name,
    required final String avatar,
  }) async {
    emit(const CreatingUser());

    final result = await _createUser(CreateUserParams(
      createdAt: createdAt,
      name: name,
      avatar: avatar,
    ));

    result.fold((failure) => emit(CreateUserFailure(failure.errorMessage)),
        (_) => emit(const UserCreated()));
  }

  Future<void> getUsers() async {
    emit(const GettingUsers());

    final result = await _getUsers();

    result.fold((failure) => emit(GetUsersFailure(failure.errorMessage)),
        (response) => emit(UsersLoaded(response)));
  }
}
