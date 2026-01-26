import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../services/auth_storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
     _navigate();
    
  }

  Future<void> _navigate() async {
    // 1. Minimum display time for the splash screen
    await Future.delayed(const Duration(seconds: 2));

    // 2. Retrieve both auth and onboarding status
    final token = await AuthStorage.getToken();
    final isDone = await AuthStorage.isOnboardingDone();
    
    debugPrint('SPLASH TOKEN: $token');
    debugPrint('ONBOARDING DONE: $isDone');

    if (!mounted) return;

    // 3. Navigation Decision Tree
    if (token != null && token.isNotEmpty) {
      // User is logged in
      if (isDone) {
        // Go to Home/Dashboard
        Navigator.pushReplacementNamed(context, '/final_score');
      } else {
        // Logged in but unfinished onboarding
        Navigator.pushReplacementNamed(context, '/intro');
      }
    } else {
      // User is NOT logged in - Start from the beginning
      Navigator.pushReplacementNamed(context, '/welcome');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBlue,
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            // Character Image
            Center(child: Image.asset('assets/images/splash.png', width: 220)),
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
            const SizedBox(height: 20),
            // Optional: Add a subtle loading indicator
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black26),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
