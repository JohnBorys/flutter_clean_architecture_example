import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture_example/src/features/users/domain/entity/user.dart';
import 'package:flutter_clean_architecture_example/src/features/users/domain/usecases/create_user.dart';
import 'package:flutter_clean_architecture_example/src/features/users/domain/usecases/get_users.dart';

part 'users_event.dart';
part 'users_state.dart';

class UserBloc extends Bloc<UsersEvent, UserState> {
  UserBloc({
    required final CreateUser createUser,
    required final GetUsers getUsers,
  })  : _createUser = createUser,
        _getUsers = getUsers,
        super(UserInitial()) {
    on<CreateUserEvent>(_createUserHandler);
    on<GetUsersEvent>(_getUsersHandler);
  }

  final CreateUser _createUser;
  final GetUsers _getUsers;

  Future<void> _createUserHandler(
    final CreateUserEvent event,
    final Emitter<UserState> emit,
  ) async {
    emit(const CreatingUser());

    final result = await _createUser(CreateUserParams(
      createdAt: event.createdAt,
      name: event.name,
      avatar: event.avatar,
    ));

    result.fold((failure) => emit(CreateUserFailure(failure.errorMessage)),
        (_) => emit(const UserCreated()));
  }

  Future<void> _getUsersHandler(
    final GetUsersEvent event,
    final Emitter<UserState> emit,
  ) async {
    emit(const GettingUsers());

    final result = await _getUsers();

    result.fold((failure) => emit(GetUsersFailure(failure.errorMessage)),
        (response) => emit(UsersLoaded(response)));
  }
}
