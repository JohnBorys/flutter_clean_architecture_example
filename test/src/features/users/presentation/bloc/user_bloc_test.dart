import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_example/core/error/failure.dart';
import 'package:flutter_clean_architecture_example/src/features/users/domain/usecases/create_user.dart';
import 'package:flutter_clean_architecture_example/src/features/users/domain/usecases/get_users.dart';
import 'package:flutter_clean_architecture_example/src/features/users/presentation/bloc/users_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCreateUser extends Mock implements CreateUser {}

class MockGetUsers extends Mock implements GetUsers {}

void main() {
  late CreateUser createUser;
  late GetUsers getUsers;
  late UsersBloc bloc;

  const tCreateUserParams = CreateUserParams.empty();
  const tApiFailure = ApiFailure(message: 'message', statusCode: 400);

  setUp(() {
    createUser = MockCreateUser();
    getUsers = MockGetUsers();
    bloc = UsersBloc(createUser: createUser, getUsers: getUsers);
    registerFallbackValue(tCreateUserParams);
  });

  tearDown(() => bloc.close());

  test('initial state should be [UserInitial]', () {
    expect(bloc.state, const UserInitial());
  });

  group('createUser', () {
    blocTest<UsersBloc, UsersState>(
      'should emit [CreatingUser, UserCreated] when successful.',
      build: () {
        when(() => createUser(any()))
            .thenAnswer((_) async => const Right(null));
        return bloc;
      },
      act: (bloc) => bloc.add(CreateUserEvent(
        createdAt: tCreateUserParams.createdAt,
        name: tCreateUserParams.name,
        avatar: tCreateUserParams.avatar,
      ),),
      expect: () => const <UsersState>[
        CreatingUser(),
        UserCreated(),
      ],
      verify: (_) {
        verify(() => createUser(tCreateUserParams)).called(1);
        verifyNoMoreInteractions(createUser);
      },
    );

    blocTest<UsersBloc, UsersState>(
      'should emit [CreatingUser, CreateUserFailure] when unsuccessful.',
      build: () {
        when(() => createUser(any()))
            .thenAnswer((_) async => const Left(tApiFailure));
        return bloc;
      },
      act: (bloc) => bloc.add(CreateUserEvent(
        createdAt: tCreateUserParams.createdAt,
        name: tCreateUserParams.name,
        avatar: tCreateUserParams.avatar,
      ),),
      expect: () => [
        const CreatingUser(),
        CreateUserFailure(tApiFailure.errorMessage),
      ],
      verify: (_) {
        verify(() => createUser(tCreateUserParams)).called(1);
        verifyNoMoreInteractions(createUser);
      },
    );
  });

  group('getUsers', () {
    blocTest<UsersBloc, UsersState>(
      'should emit [GettingUsers, UsersLoaded] when successful.',
      build: () {
        when(() => getUsers()).thenAnswer((_) async => const Right([]));
        return bloc;
      },
      act: (bloc) => bloc.add(const GetUsersEvent()),
      expect: () => const <UsersState>[
        GettingUsers(),
        UsersLoaded([]),
      ],
      verify: (_) {
        verify(() => getUsers()).called(1);
        verifyNoMoreInteractions(getUsers);
      },
    );

    blocTest<UsersBloc, UsersState>(
      'should emit [GettingUsers, GetUsersFailure] when unsuccessful.',
      build: () {
        when(() => getUsers()).thenAnswer((_) async => const Left(tApiFailure));
        return bloc;
      },
      act: (bloc) => bloc.add(const GetUsersEvent()),
      expect: () => [
        const GettingUsers(),
        GetUsersFailure(tApiFailure.errorMessage),
      ],
      verify: (_) {
        verify(() => getUsers()).called(1);
        verifyNoMoreInteractions(getUsers);
      },
    );
  });
}
