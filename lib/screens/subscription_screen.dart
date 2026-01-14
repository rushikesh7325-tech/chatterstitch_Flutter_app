import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../utils/colors.dart';

class SubscriptionScreen extends StatefulWidget {
  final String selectedLanguage;

  const SubscriptionScreen({super.key, required this.selectedLanguage});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  int? selectedIndex;

  // Frame 18 specific logic: Change text based on selection
  String get speechText {
    if (selectedIndex == 1) return "Awesome! you can upgrade many anytime.";
    return "How do you want to get started?";
  }

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
            value: 0.95,
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
                        child: _buildSpeechBubble(speechText),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  
                  // Card 0: Super ChatterStitch
                  _buildSubscriptionCard(
                    index: 0,
                    title: "Super ChatterStitch",
                    subtitle: "Faster progess, No adds",
                    hasBadge: true,
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Card 1: Learn for free (Selected in Frame 18)
                  _buildSubscriptionCard(
                    index: 1,
                    title: "Learn for free",
                    subtitle: "Core learning features, with adds",
                    hasBadge: false,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: CustomButton(
              text: 'Continue',
              // Button is now enabled because index is selected
              onPressed: selectedIndex == null ? null : () {
  Navigator.pushNamed(context, '/start_point', arguments: widget.selectedLanguage);
},
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSubscriptionCard({
    required int index,
    required String title,
    required String subtitle,
    required bool hasBadge,
  }) {
    bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () => setState(() => selectedIndex = index),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              // Frame 18 uses a specific Cyan for selection
              color: isSelected ? const Color(0xFF64E9FF) : Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: isSelected ? AppColors.primaryBlue : Colors.grey.shade300,
                width: 2,
              ),
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4)),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 16, color: Colors.black87),
                ),
              ],
            ),
          ),
          if (hasBadge)
            Positioned(
              top: -12,
              right: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'RECOMMENDED',
                  style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
            ),
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
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Text(text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
    );
  }
}