import 'dart:convert';

import 'package:flutter_clean_architecture_example/src/features/data/models/user_model.dart';
import 'package:flutter_clean_architecture_example/src/features/domain/entity/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_clean_architecture_example/src/core/utils/typedef.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const UserModel tModel = UserModel.empty();

  test('Should be a subclass of [User] entity', () {
    expect(tModel, isA<User>());
  });

  final tJson = fixture('user.json');
  final tMap = jsonDecode(tJson) as DataMap;

  group('fromMap', () {
    test('should return a [UserModel] with the right data', () {
      final result = UserModel.fromMap(tMap);
      expect(result, equals(tModel));

      //
    });
  });

  group('fromJson', () {
    test('should return a [UserModel] with the right data', () {
      final result = UserModel.fromJson(tJson);
      expect(result, equals(tModel));

      //
    });
  });

  group('toMap', () {
    test('should return a [Map] with the right data', () {
      final result = tModel.toMap();

      expect(result, equals(tMap));
    });
  });

  group('toJson', () {
    test('should return a [Json] string with the right data', () {
      // Arrage

      // Act
      final result = tModel.toJson();

      final tJson = jsonEncode({
        "createdAt": "2025-03-02T20:29:10.104Z",
        "name": "Silvia Wunsch",
        "avatar":
            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1091.jpg",
        "id": "1"
      });

      // Assert
      expect(result, tJson);
    });
  });
}
