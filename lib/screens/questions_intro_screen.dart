import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../utils/colors.dart';

class QuestionsIntroScreen extends StatelessWidget {
  const QuestionsIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SizedBox.expand(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(),
                
                // Speech Bubble with Pointer on the left
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(width: 40), // Offset to align with Stitch
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: RichText(
                        text: const TextSpan(
                          style: TextStyle(fontSize: 16, color: Colors.black),
                          children: [
                            TextSpan(text: 'Just '),
                            TextSpan(
                              text: '7 quick questions',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: ' before\nwe start your first lesson'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                // Character Image (Aligned Left)
                Transform.translate(
                  offset: const Offset(-60, 0), // Moves Stitch slightly off-screen to the left
                  child: Image.asset(
                    'assets/images/stitch_side.png',
                    height: 250,
                    alignment: Alignment.centerLeft,
                  ),
                ),
                
                const Spacer(),
                
                CustomButton(
                  text: 'Continue',
                  onPressed: () {
  Navigator.pushNamed(context, '/select_language');
},
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}