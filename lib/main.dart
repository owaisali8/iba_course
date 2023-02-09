import 'package:flutter/material.dart';
import 'package:iba_course/login_screen.dart';

void main() {
  runApp(const RestartWidget(child:MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign In Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: true,
      home: const LoginScreen(),
    );
  }
}
