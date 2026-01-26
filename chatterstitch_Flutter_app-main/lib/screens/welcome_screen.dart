import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../utils/colors.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const Spacer(),
              Image.asset('assets/images/welcome.png', width: 220),
              const SizedBox(height: 24),
              const Text(
                'ChatterStitch',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textBlack,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'chat in any language',
                style: TextStyle(fontSize: 16, color: AppColors.textGrey),
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomButton(
                    text: 'Get Started',
                    onPressed: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomButton(
                    text: 'I Already have an App',
                    isSecondary: true,
                    onPressed: () {
                     Navigator.pushNamed(context, '/login');
                    },
                  ),
                ],
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
