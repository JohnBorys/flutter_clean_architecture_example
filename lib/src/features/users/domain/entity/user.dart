import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.avatar,
  });

  const User.empty() : this(id: '-1', createdAt: '', name: '', avatar: '');

  final String id;
  final String createdAt;
  final String name;
  final String avatar;

  @override
  List<Object?> get props => [id, createdAt, name, avatar];
}
