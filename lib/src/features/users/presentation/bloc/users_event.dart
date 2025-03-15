part of 'users_bloc.dart';

sealed class UsersEvent extends Equatable {
  const UsersEvent();

  @override
  List<Object> get props => [];
}

final class CreateUserEvent extends UsersEvent {
  const CreateUserEvent({
    required this.createdAt,
    required this.avatar,
    required this.name,
  });

  final String createdAt;
  final String avatar;
  final String name;

  @override
  List<Object> get props => [createdAt, avatar, name];
}

final class GetUsersEvent extends UsersEvent {
  const GetUsersEvent();
}
