import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../utils/colors.dart';

class WidgetIntroScreen extends StatelessWidget {
  final String selectedLanguage;

  const WidgetIntroScreen({super.key, required this.selectedLanguage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: const LinearProgressIndicator(
            value: 0.85,
            backgroundColor: Color(0xFFE0E0E0),
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryBlue),
            minHeight: 10,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Image.asset('assets/images/stitch_reading.png', width: 60),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildSpeechBubble("I'll cheer you on from your home screen?"),
                        ),
                      ],
                    ),
                    const SizedBox(height: 60),
                    Center(
                      child: Image.asset(
                        'assets/images/widget_mockup.png', // The phone with the widget
                        width: MediaQuery.of(context).size.width * 0.7,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.phone_android, size: 200, color: Colors.blueGrey),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                CustomButton(
                  text: 'Add widget',
                  onPressed: () => _navigateToAchievements(context),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () => _navigateToAchievements(context),
                  child: const Text(
                    'Not Now',
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToAchievements(BuildContext context) {
    Navigator.pushNamed(context, '/achievements_summary', arguments: selectedLanguage);
  }

  Widget _buildSpeechBubble(String text) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Text(text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
    );
  }
}