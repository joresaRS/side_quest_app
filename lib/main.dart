import 'package:flutter/material.dart';
import 'package:side_quest_app/auth/screen/google_login_screen.dart';
import 'package:side_quest_app/pages/home_page.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const GoogleLoginScreen(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}
