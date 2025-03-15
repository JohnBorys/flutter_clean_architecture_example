part of 'users_bloc.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UserInitial extends UserState {
  const UserInitial();
}

final class CreatingUser extends UserState {
  const CreatingUser();
}

final class UserCreated extends UserState {
  const UserCreated();
}

final class CreateUserFailure extends UserState {
  final String error;

  const CreateUserFailure(this.error);

  @override
  List<Object> get props => [error];
}

final class GettingUsers extends UserState {
  const GettingUsers();
}

final class UsersLoaded extends UserState {
  final List<User> users;

  const UsersLoaded(this.users);

  @override
  List<Object> get props => users.map((user) => user.id).toList();
}

final class GetUsersFailure extends UserState {
  final String error;

  const GetUsersFailure(this.error);

  @override
  List<Object> get props => [error];
}
