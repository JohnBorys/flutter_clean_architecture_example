import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_example/src/features/users/presentation/bloc/users_bloc.dart';

class AddUserDialog extends StatelessWidget {
  const AddUserDialog({required this.nameController, super.key});

  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  const avatar = 'https//cloudflare-ipfs.com/ipfs/Qnd3W5Duh'
                      'gHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1203.jpg';
                  final name = nameController.text.trim();
                  context.read<UsersBloc>().add(CreateUserEvent(
                        createdAt: DateTime.now().toString(),
                        name: name,
                        avatar: avatar,
                      ),);
                  Navigator.of(context).pop();
                },
                child: const Text('Create User'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
