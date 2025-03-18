import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_example/core/utils/typedef.dart';
import 'package:flutter_clean_architecture_example/src/features/users/domain/entity/user.dart';

@immutable
final class UserModel extends User {
  const UserModel({
    required super.id,
    required super.createdAt,
    required super.name,
    required super.avatar,
  });

  const UserModel.empty()
      : this(
          createdAt: '2025-03-02T20:29:10.104Z',
          name: 'Silvia Wunsch',
          avatar:
              'https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1091.jpg',
          id: '1',
        );

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(jsonDecode(source) as DataMap);

  UserModel.fromMap(DataMap map)
      : this(
          id: map['id'] as String,
          name: map['name'] as String,
          avatar: map['avatar'] as String,
          createdAt: map['createdAt'] as String,
        );

  UserModel copyWith({
    String? id,
    String? name,
    String? avatar,
    String? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  DataMap toMap() => LinkedHashMap.from({
        'createdAt': createdAt,
        'name': name,
        'avatar': avatar,
        'id': id,
      });

  String toJson() => jsonEncode(toMap());

  @override
  List<Object?> get props => [id];

  @override
  bool? get stringify => true;
}
