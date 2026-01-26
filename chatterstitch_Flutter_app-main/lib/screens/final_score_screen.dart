import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../utils/colors.dart';

class FinalScoreScreen extends StatelessWidget {
  const FinalScoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: constraints.maxHeight),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              _buildSpeechBubble(
                                "Since you know few words lets start at score 10!",
                              ),
                              const SizedBox(height: 40),
                              Image.asset(
                                'assets/images/stitch_thumbs_up.png', 
                                width: MediaQuery.of(context).size.width * 0.7,
                                height: 300, 
                                fit: BoxFit.contain,
                                // This prevents the crash if the image is missing
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.thumb_up, size: 150, color: Colors.blue),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: CustomButton(
                text: 'Continue',
                onPressed: () {
                  // Navigate to home or dashboard
                  print("Onboarding Complete!");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpeechBubble(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300, width: 2),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: const TextStyle(fontSize: 18, color: Colors.black, height: 1.4),
          children: [
            const TextSpan(text: "Since you know few words lets start at "),
            TextSpan(
              text: "score 10!",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}