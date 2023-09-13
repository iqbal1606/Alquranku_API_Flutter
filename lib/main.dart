import 'package:alquran/loading.dart';
import 'package:alquran/register.dart';
import './home.dart';
import './index.dart';
import './login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const SplashScreen(),
        '/index': (context) =>
            const Index(), // Rute untuk halaman utama aplikasi (main.dart)
        '/myhome': (context) => const Myhome(),
        '/register': (context) => Register(),
        '/login': (context) => login(),
      },
    );
  }
}
