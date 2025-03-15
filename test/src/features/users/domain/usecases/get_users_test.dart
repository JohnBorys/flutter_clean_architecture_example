import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_clean_architecture_example/src/features/users/domain/repositories/users_repository.dart';
import 'package:flutter_clean_architecture_example/src/features/users/domain/usecases/create_user.dart';

class MockUsersRepository extends Mock implements UsersRepository {}

void main() {
  late CreateUser usecase;
  late UsersRepository repository;

  setUp(() {
    repository = MockUsersRepository();
    usecase = CreateUser(repository: repository);
  });

  const params = CreateUserParams.empty();

  test('should call the [AuthRepo.createUser]', () async {
    when(
      () => repository.createUser(
        createdAt: any(named: 'createdAt'),
        name: any(named: 'name'),
        avatar: any(named: 'avatar'),
      ),
    ).thenAnswer((_) async => const Right(null));

    final result = await usecase(params);

    expect(result, equals(const Right<dynamic, void>(null)));
    verify(
      () => repository.createUser(
        createdAt: params.createdAt,
        name: params.name,
        avatar: params.avatar,
      ),
    ).called(1);
    verifyNoMoreInteractions(repository);
  });
}
