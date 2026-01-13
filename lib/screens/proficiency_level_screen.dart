import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../utils/colors.dart';

class ProficiencyLevelScreen extends StatefulWidget {
  final String selectedLanguage;

  const ProficiencyLevelScreen({super.key, required this.selectedLanguage});

  @override
  State<ProficiencyLevelScreen> createState() => _ProficiencyLevelScreenState();
}

class _ProficiencyLevelScreenState extends State<ProficiencyLevelScreen> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    // MOVE THE LIST HERE: Now it uses the actual language you picked!
    final List<Map<String, dynamic>> dynamicLevels = [
      {'text': 'I am new to ${widget.selectedLanguage}', 'bars': 1},
      {'text': 'I know some common words', 'bars': 2},
      {'text': 'I can have basic conversation', 'bars': 3},
      {'text': 'I can talk about various topics', 'bars': 4},
      {'text': 'I can discuss most topics in detail', 'bars': 5},
    ];

    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: const LinearProgressIndicator(
            value: 0.4, // Progress is increasing
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
                        child: _buildSpeechBubble("How much ${widget.selectedLanguage} do you know?"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  // Use dynamicLevels here
                  ...List.generate(dynamicLevels.length, (index) {
                    return _buildLevelTile(
                      index,
                      dynamicLevels[index]['text'],
                      dynamicLevels[index]['bars'],
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
              onPressed: selectedIndex == null ? null : () {
                Navigator.pushNamed(context, '/learning_reason', arguments: widget.selectedLanguage);// Navigate to the "How did you hear about us?" screen
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // ... (Keep your _buildSpeechBubble, _buildLevelTile, and _buildBarIcon methods exactly as they are)

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

  Widget _buildLevelTile(int index, String text, int barCount) {
    bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () => setState(() => selectedIndex = index),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFB2EBF2).withOpacity(0.5) : Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected ? AppColors.primaryBlue : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
        ),
        child: Row(
          children: [
            _buildBarIcon(barCount, isSelected),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBarIcon(int activeBars, bool isSelected) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: List.generate(5, (i) {
        return Container(
          width: 6,
          height: 10.0 + (i * 5),
          margin: const EdgeInsets.symmetric(horizontal: 1),
          decoration: BoxDecoration(
            color: i < activeBars ? AppColors.primaryBlue : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(2),
          ),
        );
      }),
    );
  }
}