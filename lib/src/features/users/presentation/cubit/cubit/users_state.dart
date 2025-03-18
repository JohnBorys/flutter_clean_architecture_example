part of 'users_cubit.dart';

sealed class UsersState extends Equatable {
  const UsersState();

  @override
  List<Object> get props => [];
}

final class UsersInitial extends UsersState {
  const UsersInitial();
}

final class CreatingUser extends UsersState {
  const CreatingUser();
}

final class UserCreated extends UsersState {
  const UserCreated();
}

final class CreateUserFailure extends UsersState {

  const CreateUserFailure(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}

final class GettingUsers extends UsersState {
  const GettingUsers();
}

final class UsersLoaded extends UsersState {

  const UsersLoaded(this.users);
  final List<User> users;

  @override
  List<Object> get props => users.map((user) => user.id).toList();
}

final class GetUsersFailure extends UsersState {

  const GetUsersFailure(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}
