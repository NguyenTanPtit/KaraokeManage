import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karaoke_manage/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:karaoke_manage/features/auth/presentation/bloc/auth_event.dart';

class ManagerHomeScreen extends StatelessWidget {
  const ManagerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manager Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthBloc>().add(AuthLogoutRequested());
              Navigator.of(context).pushReplacementNamed('/login');
            },
          ),
        ],
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.dashboard, size: 100, color: Colors.blue),
            SizedBox(height: 20),
            Text(
              'Welcome, Manager!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Use the navigation to manage rooms, orders, and reports.'),
          ],
        ),
      ),
    );
  }
}
