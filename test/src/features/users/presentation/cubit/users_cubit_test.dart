import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_example/src/core/error/failure.dart';
import 'package:flutter_clean_architecture_example/src/features/users/domain/usecases/create_user.dart';
import 'package:flutter_clean_architecture_example/src/features/users/domain/usecases/get_users.dart';
import 'package:flutter_clean_architecture_example/src/features/users/presentation/cubit/cubit/users_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCreateUser extends Mock implements CreateUser {}

class MockGetUsers extends Mock implements GetUsers {}

void main() {
  late CreateUser createUser;
  late GetUsers getUsers;
  late UsersCubit cubit;

  const tCreateUserParams = CreateUserParams.empty();
  const tApiFailure = ApiFailure(message: 'message', statusCode: 400);

  setUp(() {
    createUser = MockCreateUser();
    getUsers = MockGetUsers();
    cubit = UsersCubit(createUser: createUser, getUsers: getUsers);
    registerFallbackValue(tCreateUserParams);
  });

  tearDown(() => cubit.close());

  test('initial state should be [UsersInitial]', () {
    expect(cubit.state, const UsersInitial());
  });

  group('createUser', () {
    blocTest<UsersCubit, UsersState>(
      'should emit [CreatingUser, UserCreated] when successful.',
      build: () {
        when(() => createUser(any()))
            .thenAnswer((_) async => const Right(null));
        return cubit;
      },
      act: (cubit) => cubit.createUser(
        createdAt: tCreateUserParams.createdAt,
        name: tCreateUserParams.name,
        avatar: tCreateUserParams.avatar,
      ),
      expect: () => const <UsersState>[
        CreatingUser(),
        UserCreated(),
      ],
      verify: (_) {
        verify(() => createUser(tCreateUserParams)).called(1);
        verifyNoMoreInteractions(createUser);
      },
    );

    blocTest<UsersCubit, UsersState>(
      'should emit [CreatingUser, CreateUserFailure] when unsuccessful.',
      build: () {
        when(() => createUser(any()))
            .thenAnswer((_) async => const Left(tApiFailure));
        return cubit;
      },
      act: (cubit) => cubit.createUser(
        createdAt: tCreateUserParams.createdAt,
        name: tCreateUserParams.name,
        avatar: tCreateUserParams.avatar,
      ),
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
    blocTest<UsersCubit, UsersState>(
      'should emit [GettingUsers, UsersLoaded] when successful.',
      build: () {
        when(() => getUsers()).thenAnswer((_) async => const Right([]));
        return cubit;
      },
      act: (cubit) => cubit.getUsers(),
      expect: () => const <UsersState>[
        GettingUsers(),
        UsersLoaded([]),
      ],
      verify: (_) {
        verify(() => getUsers()).called(1);
        verifyNoMoreInteractions(getUsers);
      },
    );

    blocTest<UsersCubit, UsersState>(
      'should emit [GettingUsers, GetUsersFailure] when unsuccessful.',
      build: () {
        when(() => getUsers()).thenAnswer((_) async => const Left(tApiFailure));
        return cubit;
      },
      act: (cubit) => cubit.getUsers(),
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
