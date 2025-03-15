import 'dart:convert';

import 'package:flutter_clean_architecture_example/src/core/constants/constants.dart';
import 'package:flutter_clean_architecture_example/src/core/error/exceptions.dart';
import 'package:flutter_clean_architecture_example/src/core/utils/typedef.dart';
import 'package:flutter_clean_architecture_example/src/features/users/data/models/user_model.dart';
import 'package:http/http.dart' as http;

abstract class UsersRemoteDataSource {
  Future<void> createUser({
    required final String createdAt,
    required final String name,
    required final String avatar,
  });

  Future<List<UserModel>> getUsers();
}

const kCreateUserEndpoint = '/test-api/users';
const kGetUsersEndpoint = '/test-api/users';

base class UsersRemoteDataSourceImpl implements UsersRemoteDataSource {
  const UsersRemoteDataSourceImpl({required this.client});

  final http.Client client;

  @override
  Future<void> createUser({
    required final String createdAt,
    required final String name,
    required final String avatar,
  }) async {
    final response = await _postRequest(
      endpoint: kCreateUserEndpoint,
      body: {'createdAt': createdAt, 'name': name, 'avatar': avatar},
    );

    _handleResponse(response);
  }

  @override
  Future<List<UserModel>> getUsers() async {
    final response = await _getRequest(endpoint: kGetUsersEndpoint);

    _handleResponse(response);

    final List<dynamic> decodedBody =
        jsonDecode(response.body) as List<dynamic>;
    return decodedBody
        .map((userData) => UserModel.fromMap(userData as DataMap))
        .toList();
  }

  Future<http.Response> _postRequest({
    required final String endpoint,
    required final Map<String, dynamic> body,
  }) async {
    try {
      return await client.post(
        Uri.https(kBaseUrl, endpoint),
        body: jsonEncode(body),
      );
    } catch (e) {
      throw ApiException(message: e.toString(), statusCode: 505);
    }
  }

  Future<http.Response> _getRequest({required final String endpoint}) async {
    try {
      return await client.get(Uri.https(kBaseUrl, endpoint));
    } catch (e) {
      throw ApiException(message: e.toString(), statusCode: 505);
    }
  }

  void _handleResponse(http.Response response) {
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw ApiException(
          message: response.body, statusCode: response.statusCode);
    }
  }
}
