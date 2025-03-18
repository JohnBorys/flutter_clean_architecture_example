import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_example/core/services/injection_container.dart';
import 'package:flutter_clean_architecture_example/src/features/users/presentation/bloc/users_bloc.dart';
import 'package:flutter_clean_architecture_example/src/features/users/presentation/views/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<UsersBloc>(),
      child: MaterialApp(
        title: 'Flutter Clean Architecture Example',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
