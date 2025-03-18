import 'dart:convert';

import 'package:flutter_clean_architecture_example/core/constants/constants.dart';
import 'package:flutter_clean_architecture_example/core/error/exceptions.dart';
import 'package:flutter_clean_architecture_example/core/utils/typedef.dart';
import 'package:flutter_clean_architecture_example/src/features/users/data/models/user_model.dart';
import 'package:http/http.dart' as http;

abstract class UsersRemoteDataSource {
  Future<void> createUser({
    required String createdAt,
    required String name,
    required String avatar,
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
    required String createdAt,
    required String name,
    required String avatar,
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

    final decodedBody = jsonDecode(response.body) as List<dynamic>;
    return decodedBody
        .map((userData) => UserModel.fromMap(userData as DataMap))
        .toList();
  }

  Future<http.Response> _postRequest({
    required String endpoint,
    required Map<String, dynamic> body,
  }) async {
    try {
      return await client.post(
        Uri.https(kBaseUrl, endpoint),
        body: jsonEncode(body),
        headers: {'Content-Type': 'application/json'},
      );
    } catch (e) {
      throw ApiException(message: e.toString(), statusCode: 505);
    }
  }

  Future<http.Response> _getRequest({required String endpoint}) async {
    try {
      final uri = Uri.https(kBaseUrl, endpoint);
      return await client.get(uri);
    } catch (e) {
      throw ApiException(message: e.toString(), statusCode: 505);
    }
  }

  void _handleResponse(http.Response response) {
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw ApiException(
        message: response.body,
        statusCode: response.statusCode,
      );
    }
  }
}
