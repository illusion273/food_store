import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_store/logic/blocs/app/app_bloc.dart';
import 'package:food_store/logic/blocs/auth/auth_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.read<AppBloc>().add(AppSignOutRequested()),
          child: const Text("Sign out"),
        ),
      ),
    );
  }
}
