import 'package:flutter/material.dart';
import '../utils/colors.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() => _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  // Store the name of the selected language
  String? selectedLanguage;

  // List of languages to display
  final List<Map<String, String>> languages = [
    {'name': 'Spanish', 'flag': 'assets/images/spain.png'},
    {'name': 'French', 'flag': 'assets/images/france.png'},
    {'name': 'German', 'flag': 'assets/images/germany.png'},
    {'name': 'Italian', 'flag': 'assets/images/italy.png'},
    {'name': 'Intermediate English', 'flag': 'assets/images/uk.png'},
    {'name': 'Japanese', 'flag': 'assets/images/japan.png'},
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
            value: 0.2, // Match the progress in your image
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  // Stitch header
                  Row(
                    children: [
                      Image.asset('assets/images/stitch_reading.png', width: 60),
                      const SizedBox(width: 12),
                      _buildSpeechBubble("What would you like to learn?"),
                    ],
                  ),
                  const SizedBox(height: 30),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("For English Speakers", 
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      Icon(Icons.keyboard_arrow_down),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Dynamic Language List
                  ...languages.map((lang) => _buildLanguageTile(lang['name']!, lang['flag']!)).toList(),
                ],
              ),
            ),
          ),
          // Bottom Button Area
          _buildBottomAction(),
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
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w500)),
    );
  }

  Widget _buildLanguageTile(String title, String assetPath) {
    bool isSelected = selectedLanguage == title;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedLanguage = title;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          // Change color based on selection (Frame 6)
          color: isSelected ? const Color(0xFFB2EBF2).withOpacity(0.5) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primaryBlue : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Image.asset(assetPath, width: 40, height: 30, fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(Icons.flag)),
            const SizedBox(width: 16),
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomAction() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: ElevatedButton(
        // Disable button if nothing is selected (Frame 5 vs 6)
        // Inside lib/screens/language_selection_screen.dart
onPressed: selectedLanguage == null ? null : () {
  Navigator.pushNamed(
    context, 
    '/course_building', 
    arguments: selectedLanguage, // This sends the choice to the next screen
  );
},
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryBlue,
          disabledBackgroundColor: Colors.grey.shade300,
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: Text(
          'Continue',
          style: TextStyle(
            fontSize: 18, 
            fontWeight: FontWeight.bold,
            color: selectedLanguage == null ? Colors.grey.shade500 : Colors.white,
          ),
        ),
      ),
    );
  }
}