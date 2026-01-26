import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../utils/colors.dart';
import 'notifications_intro_screen.dart';
class GoalConfirmationScreen extends StatelessWidget {
  final int languageId;
  final String languageName;
  final String proficiencyLevel;
  final List<String> learningReasons;
  final String dailyGoal;

  const GoalConfirmationScreen({
    super.key,
    required this.languageId,
    required this.languageName,
    required this.proficiencyLevel,
    required this.learningReasons,
    required this.dailyGoal,
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
            value: 0.8, // Almost there!
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
                  Row(
                    children: [
                      Image.asset('assets/images/stitch_reading.png', width: 60),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildSpeechBubble(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  // A nice visual icon to represent the goal
                  const Icon(Icons.auto_graph_rounded, size: 100, color: AppColors.primaryBlue),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: CustomButton(
              text: 'Continue',
              onPressed: () {
                // Moving to the final step: Notifications
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotificationsIntroScreen(
                      languageId: languageId,
                      languageName: languageName,
                      proficiencyLevel: proficiencyLevel,
                      learningReasons: learningReasons,
                      dailyGoal: dailyGoal,
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

  Widget _buildSpeechBubble() {
    // Logic: 10 mins = ~50 words/week, 20 mins = ~100 words/week
    String wordCount = dailyGoal.contains('5') ? "25" : dailyGoal.contains('10') ? "50" : "100";

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))
        ],
      ),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 16, color: Colors.black, height: 1.4),
          children: [
            const TextSpan(text: "That's "),
            TextSpan(
              text: "$wordCount words",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const TextSpan(text: " in your first week!"),
          ],
        ),
      ),
    );
  }
}