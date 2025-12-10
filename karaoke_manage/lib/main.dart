import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karaoke_manage/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:karaoke_manage/features/auth/presentation/view/login_screen.dart';
import 'package:karaoke_manage/features/home/presentation/view/manager_home_screen.dart';
import 'package:karaoke_manage/features/home/presentation/view/staff_home_screen.dart';

import 'app/di/locator.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: MaterialApp(
        title: 'Karaoke Management System',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        initialRoute: '/login',
        routes: {
          '/login': (context) => const LoginScreen(),
          '/manager_home': (context) => const ManagerHomeScreen(),
          '/staff_home': (context) => const StaffHomeScreen(),
        },
      ),
    );
  }
}
