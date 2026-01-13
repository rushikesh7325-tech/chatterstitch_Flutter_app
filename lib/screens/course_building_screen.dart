import 'package:flutter/material.dart';
import 'dart:async';
import '../utils/colors.dart';

class CourseBuildingScreen extends StatefulWidget {
  final String selectedLanguage;

  const CourseBuildingScreen({super.key, required this.selectedLanguage});

  @override
  State<CourseBuildingScreen> createState() => _CourseBuildingScreenState();
}

class _CourseBuildingScreenState extends State<CourseBuildingScreen> {
  @override
  void initState() {
    super.initState();
    // Transition after 3 seconds
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacementNamed(
          context, 
          '/proficiency', 
          arguments: widget.selectedLanguage,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: SafeArea(
        // Center widget ensures the entire Column is centered horizontally
        child: Center( 
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              // MainAxisAlignment.center centers items vertically
              mainAxisAlignment: MainAxisAlignment.center,
              // CrossAxisAlignment.center centers items horizontally
              crossAxisAlignment: CrossAxisAlignment.center, 
              children: [
                // Character Image
                Image.asset(
                  'assets/images/stitch_laying.png',
                  width: 200,
                  // errorBuilder helps if the image hasn't loaded yet
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.hourglass_empty, size: 100),
                ),
                const SizedBox(height: 32),
                
                // Title
                const Text(
                  'Course Building...',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 16),
                
                // Description
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                    children: [
                      const TextSpan(text: 'Get ready to join the '),
                      const TextSpan(
                        text: '7 million people',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const TextSpan(text: ' currently learning '),
                      TextSpan(
                        text: widget.selectedLanguage,
                        style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryBlue),
                      ),
                      const TextSpan(text: ' with ChatterStitch!'),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                
                // Loading Indicator
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryBlue),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}