import 'dart:convert';

import 'package:flutter_clean_architecture_example/core/constants/constants.dart';
import 'package:flutter_clean_architecture_example/core/error/exceptions.dart';
import 'package:flutter_clean_architecture_example/src/features/users/data/data_sources/users_remote_data_source.dart';
import 'package:flutter_clean_architecture_example/src/features/users/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

class MockClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late UsersRemoteDataSource remoteDataSource;

  setUp(() {
    client = MockClient();
    remoteDataSource = UsersRemoteDataSourceImpl(client: client);
    registerFallbackValue(Uri());
  });

  group('createUser', () {
    const tCreatedAt = 'createdAt';
    const tName = 'name';
    const tAvatar = 'avatar';
    final tBody = jsonEncode({
      'createdAt': tCreatedAt,
      'name': tName,
      'avatar': tAvatar,
    });

    test('should complete successfully when the status code is 200 or 201',
        () async {
      when(() => client.post(any(), body: any(named: 'body'))).thenAnswer(
          (_) async => http.Response('User created successfully', 201));

      final methodCall = remoteDataSource.createUser;

      expect(methodCall(createdAt: tCreatedAt, name: tName, avatar: tAvatar),
          completes);

      verify(() => client.post(
            Uri.https(kBaseUrl, kCreateUserEndpoint),
            body: tBody,
          )).called(1);

      verifyNoMoreInteractions(client);
    });

    test('should throw [ApiException] when the status code is not 200 or 201',
        () async {
      when(() => client.post(any(), body: any(named: 'body')))
          .thenAnswer((_) async => http.Response('Invalid email address', 400));

      final methodCall = remoteDataSource.createUser;

      expect(
          () async =>
              methodCall(createdAt: tCreatedAt, name: tName, avatar: tAvatar),
          throwsA(const ApiException(
              message: 'Invalid email address', statusCode: 400)));

      verify(() => client.post(
            Uri.https(kBaseUrl, kCreateUserEndpoint),
            body: tBody,
          )).called(1);

      verifyNoMoreInteractions(client);
    });
  });

  group('getUsers', () {
    const tUsers = [UserModel.empty()];
    final tResponse = jsonEncode([tUsers.first.toMap()]);

    test('should return [List<User>] when the status code is 200', () async {
      when(() => client.get(any()))
          .thenAnswer((_) async => http.Response(tResponse, 200));

      final result = await remoteDataSource.getUsers();

      expect(result, equals(tUsers));

      verify(() => client.get(Uri.https(kBaseUrl, kGetUsersEndpoint)))
          .called(1);

      verifyNoMoreInteractions(client);
    });

    test('should throw [ApiException] when the status code is not 200 or 201',
        () async {
      const tMessage = 'Server down';
      when(() => client.get(any()))
          .thenAnswer((_) async => http.Response(tMessage, 500));

      final methodCall = remoteDataSource.getUsers;

      expect(() async => methodCall(),
          throwsA(const ApiException(message: tMessage, statusCode: 500)));

      verify(() => client.get(Uri.https(kBaseUrl, kGetUsersEndpoint)))
          .called(1);

      verifyNoMoreInteractions(client);
    });
  });
}
