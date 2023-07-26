import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uas_mobprog_miqdad/views/create.dart';
import 'package:uas_mobprog_miqdad/views/home.dart';
import 'package:uas_mobprog_miqdad/views/login.dart';
import 'package:uas_mobprog_miqdad/views/profile.dart';
import 'package:uas_mobprog_miqdad/views/register.dart';
import 'package:uas_mobprog_miqdad/views/started_screen.dart';

import 'views/splash_screen.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white, statusBarIconBrightness: Brightness.dark));

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomeScreen(),
        '/get-started': (context) => const GetStartedScreen(),
        '/register': (context) => const SignUpScreen(),
        '/login': (context) => const SignInScreen(),
        '/posting': (context) => const CreatePostScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
    );
  }
}
