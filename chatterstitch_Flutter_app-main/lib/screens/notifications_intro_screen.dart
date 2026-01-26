import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../utils/colors.dart';
import 'widget_intro_screen.dart';
class NotificationsIntroScreen extends StatelessWidget {
  final int languageId;
  final String languageName;
  final String proficiencyLevel;
  final List<String> learningReasons;
  final String dailyGoal;

  const NotificationsIntroScreen({
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
            value: 0.9, // Almost finished!
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
                        child: _buildSpeechBubble("I'll remind you to practice so it becomes an easy habit!"),
                      ),
                    ],
                  ),
                  const Spacer(),
                  _buildMockNotificationDialog(),
                  const SizedBox(height: 20),
                  Align(
                    alignment: const Alignment(0.4, 0), 
                    child: Icon(
                      Icons.arrow_upward,
                      color: Colors.cyan.shade300,
                      size: 40,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: CustomButton(
              text: 'Continue',
              onPressed: () {
                // Pass the full data bundle to the final intro screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WidgetIntroScreen(
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
  
  // ... Keep _buildSpeechBubble and _buildMockNotificationDialog as they are
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

  Widget _buildMockNotificationDialog() {
    return Container(
      width: 280,
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F7),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(
                  '"ChatterStitch" Would Like to Send You Notifications',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                SizedBox(height: 8),
                Text(
                  'Notifications may include alerts, sounds, and icon badges. These can be configured in Settings.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Colors.grey),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {},
                  child: const Text('Don\'t Allow', style: TextStyle(color: Colors.blue, fontSize: 17)),
                ),
              ),
              Container(width: 1, height: 44, color: Colors.grey),
              Expanded(
                child: TextButton(
                  onPressed: () {},
                  child: const Text('Allow', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 17)),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
