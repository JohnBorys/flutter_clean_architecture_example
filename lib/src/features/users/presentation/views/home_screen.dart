import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_example/src/features/users/presentation/bloc/users_bloc.dart';
import 'package:flutter_clean_architecture_example/src/features/users/presentation/widgets/add_user_dialog.dart';
import 'package:flutter_clean_architecture_example/src/features/users/presentation/widgets/loading_column.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    context.read<UsersBloc>().add(const GetUsersEvent());
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UsersBloc, UsersState>(
      builder: (context, state) {
        return Scaffold(
          body: state is GettingUsers
              ? const LoadingColumn(message: 'Fetching Users...')
              : state is CreatingUser
                  ? const LoadingColumn(message: 'Creating User')
                  : state is UsersLoaded
                      ? ListView.builder(
                          itemCount: state.users.length,
                          itemBuilder: (BuildContext context, int index) {
                            final user = state.users[index];
                            return ListTile(
                              contentPadding: const EdgeInsets.all(24),
                              leading: Image.network(
                                user.avatar,
                                height: 50,
                                width: 50,
                                loadingBuilder: (_, __, ___) =>
                                    const CircularProgressIndicator(),
                                errorBuilder: (_, __, ___) {
                                  return Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withAlpha(100),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  );
                                },
                              ),
                              title: Text(user.name),
                              subtitle: Text(user.createdAt.substring(10)),
                            );
                          },
                        )
                      : const SizedBox.shrink(),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              await showDialog<void>(
                context: context,
                builder: (context) => AddUserDialog(
                  nameController: controller,
                ),
              );
            },
            label: const Text('Add User'),
            icon: const Icon(Icons.add),
          ),
        );
      },
      listener: (BuildContext context, UsersState state) {
        if (state is GetUsersFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error)));
        } else if (state is UserCreated) {
          context.read<UsersBloc>().add(const GetUsersEvent());
        }
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
