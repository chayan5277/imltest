import 'dart:async';
import 'package:flutter/material.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.orange,
        body: Center(
            child: Text(
      '@Welcome',
      style: const TextStyle(
        fontStyle: FontStyle.italic,
        letterSpacing: 0.2,
        fontWeight: FontWeight.w600,
        fontSize: 45,color: Colors.white
      ),
    )));
  }
}
