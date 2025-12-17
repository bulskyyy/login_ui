import 'package:flutter/material.dart';
import 'screens/login_screen.dart';  // ⬅️ IMPORT LoginScreen
import 'screens/order_history_screen.dart';
import 'screens/notes_screen.dart';

void main() {
  runApp(const LoginApp());
}

class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sign in',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
      ),
      home: const LoginScreen(),  // ⬅️ HARUS LoginScreen
      routes: {
        '/orders': (context) => const OrderHistoryScreen(),
        '/notes': (context) => const NotesScreen(),
      },
    );
  }
}