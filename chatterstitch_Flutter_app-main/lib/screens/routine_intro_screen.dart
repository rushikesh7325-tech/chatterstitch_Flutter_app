import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../utils/colors.dart';
import 'daily_goal_screen.dart';

class RoutineIntroScreen extends StatelessWidget {
  final String languageName;
  final int languageId;
  final String proficiencyLevel;
 final List<String> learningReasons;

  const RoutineIntroScreen({
    super.key,
    required this.languageId,
    required this.languageName,
    required this.proficiencyLevel,
    required this.learningReasons
  });

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
            value: 0.5, // Midway point
            backgroundColor: Color(0xFFE0E0E0),
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryBlue),
            minHeight: 10,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  // Character Header
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/stitch_reading.png',
                        width: 60,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildSpeechBubble(
                          "Let's setup a learning routine",
                        ),
                      ),
                    ],
                  ),
                  // The center remains empty as per Frame 11
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: CustomButton(
              text: 'Continue',
            onPressed: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => DailyGoalScreen(
        languageId: languageId,
        languageName: languageName,
        proficiencyLevel: proficiencyLevel,
        learningReasons: learningReasons,
      ),
    ),
  );
},
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSpeechBubble(String text) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
  }
}
