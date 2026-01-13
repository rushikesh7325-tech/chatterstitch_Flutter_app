import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../utils/colors.dart';

class LearningReasonScreen extends StatefulWidget {
  final String selectedLanguage;

  const LearningReasonScreen({super.key, required this.selectedLanguage});

  @override
  State<LearningReasonScreen> createState() => _LearningReasonScreenState();
}

class _LearningReasonScreenState extends State<LearningReasonScreen> {
  // Use a set to store multiple selected reasons
  final Set<int> selectedIndices = {};

  final List<Map<String, dynamic>> reasons = [
    {'text': 'Just for fun', 'icon': 'assets/images/icon_fun.png'},
    {'text': 'Boost my career', 'icon': 'assets/images/icon_career.png'},
    {'text': 'Spend time productively', 'icon': 'assets/images/icon_brain.png'},
    {'text': 'CONNECT WITH PEOPLE', 'icon': 'assets/images/icon_people.png'},
    {'text': 'Prepare for travel', 'icon': 'assets/images/icon_travel.png'},
    {'text': 'Support my education', 'icon': 'assets/images/icon_book.png'},
    {'text': 'Others', 'icon': 'assets/images/icon_others.png'},
  ];

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
            value: 0.45,
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
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Image.asset('assets/images/stitch_reading.png', width: 60),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildSpeechBubble("Why are you learning ${widget.selectedLanguage}?"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  ...List.generate(reasons.length, (index) {
                    return _buildReasonTile(
                      index,
                      reasons[index]['text'],
                      reasons[index]['icon'],
                    );
                  }),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: CustomButton(
              text: 'Continue',
              onPressed: selectedIndices.isEmpty ? null : () {
                // Navigate to the next question screen
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
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Text(text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
    );
  }

  Widget _buildReasonTile(int index, String text, String iconPath) {
    bool isSelected = selectedIndices.contains(index);

    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            selectedIndices.remove(index);
          } else {
            selectedIndices.add(index);
          }
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected ? AppColors.primaryBlue : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
        ),
        child: Row(
          children: [
            Image.asset(iconPath, width: 30, height: 30, 
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.star, color: Colors.orange)),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
            ),
            // Checkbox
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400, width: 2),
                borderRadius: BorderRadius.circular(4),
                color: isSelected ? AppColors.primaryBlue : Colors.transparent,
              ),
              child: isSelected 
                ? const Icon(Icons.check, size: 18, color: Colors.white) 
                : null,
            ),
          ],
        ),
      ),
    );
  }
}