import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/android/login_screen.dart';

class Appgym extends StatelessWidget {
  const Appgym({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Login(),
    );
  }
}