import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_example/src/core/error/exceptions.dart';
import 'package:flutter_clean_architecture_example/src/core/error/failure.dart';
import 'package:flutter_clean_architecture_example/src/features/data/data_sources/authentication_remote_data_source.dart';
import 'package:flutter_clean_architecture_example/src/features/data/repositories/authentication_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthenticationRemoteDataSource extends Mock
    implements AuthenticationRemoteDataSource {}

void main() {
  late AuthenticationRemoteDataSource remoteDataSource;
  late AuthenticationRepositoryImpl repositoryImpl;

  setUp(() {
    remoteDataSource = MockAuthenticationRemoteDataSource();
    repositoryImpl =
        AuthenticationRepositoryImpl(remoteDataSource: remoteDataSource);
  });

  final tException = ApiException(
    message: 'Unknown Error Occured',
    statusCode: 500,
  );

  const createdAt = 'whatever.createdAt';
  const name = 'whatever.name';
  const avatar = 'whatever.avatar';

  group('createUser', () {
    test(
      'should call the [RemoteDataSource.createUser] and complete '
      'successfully when the call of the remote source is successful',
      () async {
        when(
          () => remoteDataSource.createUser(
              createdAt: any(named: 'createdAt'),
              name: any(named: 'name'),
              avatar: any(named: 'avatar')),
        ).thenAnswer((_) async => Future.value());

        final result = await repositoryImpl.createUser(
            createdAt: createdAt, name: name, avatar: avatar);

        expect(result, equals(const Right(null)));
        verify(() => remoteDataSource.createUser(
              createdAt: createdAt,
              name: name,
              avatar: avatar,
            )).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );

    test(
      'should return a [ServerFailure] when the call to the remote '
      'source is unsuccessful',
      () async {
        when(
          () => remoteDataSource.createUser(
              createdAt: any(named: 'createdAt'),
              name: any(named: 'name'),
              avatar: any(named: 'avatar')),
        ).thenThrow(tException);

        final result = await repositoryImpl.createUser(
          createdAt: createdAt,
          name: name,
          avatar: avatar,
        );

        expect(result, equals(Left(ApiFailure.fromException(tException))));

        verify(() => remoteDataSource.createUser(
            createdAt: createdAt, name: name, avatar: avatar)).called(1);

        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });

  test(
    'should return a [APIFailure] when the call to the remote '
    'source is unsuccessful',
    () async {
      when(() => remoteDataSource.getUsers()).thenThrow(tException);

      final result = await repositoryImpl.getUsers();

      expect(result, equals(Left(ApiFailure.fromException(tException))));
      verify(() => remoteDataSource.getUsers()).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    },
  );
}
