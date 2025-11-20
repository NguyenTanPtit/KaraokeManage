import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:karaoke_manage/features/auth/presentation/view/login_screen.dart';

import 'app/di/locator.dart';
import 'firebase_options.dart';

void main() async {
  // 3. Ensure widgets are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // 4. Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupLocator();
  runApp(const LoginScreen());
}

