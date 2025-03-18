import 'package:flutter_clean_architecture_example/src/features/users/data/data_sources/users_remote_data_source.dart';
import 'package:flutter_clean_architecture_example/src/features/users/data/repositories/users_repository_impl.dart';
import 'package:flutter_clean_architecture_example/src/features/users/domain/repositories/users_repository.dart';
import 'package:flutter_clean_architecture_example/src/features/users/domain/usecases/create_user.dart';
import 'package:flutter_clean_architecture_example/src/features/users/domain/usecases/get_users.dart';
import 'package:flutter_clean_architecture_example/src/features/users/presentation/bloc/users_bloc.dart';
import 'package:flutter_clean_architecture_example/src/features/users/presentation/cubit/cubit/users_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  sl

    // External Dependencies
    ..registerLazySingleton(http.Client.new)

    // Data Sources
    ..registerLazySingleton<UsersRemoteDataSource>(
        () => UsersRemoteDataSourceImpl(client: sl()),)

    // Repsositories
    ..registerLazySingleton<UsersRepository>(
        () => UsersRepositoryImpl(remoteDataSource: sl()),)

    // Use cases
    ..registerLazySingleton(() => GetUsers(
          repository: sl(),
        ),)
    ..registerLazySingleton(() => CreateUser(repository: sl()))

    // App Bussiness Logic
    ..registerFactory<UsersBloc>(
        () => UsersBloc(createUser: sl(), getUsers: sl()),)
    ..registerFactory<UsersCubit>(
        () => UsersCubit(createUser: sl(), getUsers: sl()),);
}
