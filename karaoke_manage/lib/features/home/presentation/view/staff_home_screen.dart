import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karaoke_manage/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:karaoke_manage/features/auth/presentation/bloc/auth_event.dart';

class StaffHomeScreen extends StatelessWidget {
  const StaffHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Staff Portal'),
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
            Icon(Icons.room_service, size: 100, color: Colors.green),
            SizedBox(height: 20),
            Text(
              'Welcome, Staff!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Ready to take orders and check-in guests.'),
          ],
        ),
      ),
    );
  }
}
