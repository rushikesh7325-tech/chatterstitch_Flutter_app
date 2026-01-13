import 'package:flutter/material.dart';
import 'dart:async';
import '../utils/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to WelcomeScreen after 2 seconds
    Timer(const Duration(seconds: 5), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/welcome');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBlue, // Using our utility color
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            // Character Image
            Center(
              child: Image.asset(
                'assets/images/splash.png',
                width: 220,
              ),
            ),
            const Spacer(),
            // App Name
            const Text(
              'ChatterStitch',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}