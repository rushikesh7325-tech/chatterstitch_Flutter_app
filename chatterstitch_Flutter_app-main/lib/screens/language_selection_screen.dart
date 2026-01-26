import 'package:flutter/material.dart';
import '../utils/colors.dart';
import 'course_building_screen.dart';
class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() => _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  // Store both for DB (ID) and UI (Name)
  int? selectedLanguageId;
  String? selectedLanguageName;

  final List<Map<String, dynamic>> languages = [
    {'id': 1, 'name': 'Spanish', 'flag': 'assets/images/spain.png'},
    {'id': 2, 'name': 'French', 'flag': 'assets/images/france.png'},
    {'id': 3, 'name': 'German', 'flag': 'assets/images/germany.png'},
    {'id': 4, 'name': 'Italian', 'flag': 'assets/images/italy.png'},
    {'id': 5, 'name': 'Intermediate English', 'flag': 'assets/images/uk.png'},
    {'id': 6, 'name': 'Japanese', 'flag': 'assets/images/japan.png'},
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
            value: 0.2,
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
                      Text(
                        "For English Speakers",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Icon(Icons.keyboard_arrow_down),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Build the list using the list from state
                  ...languages.map((lang) => _buildLanguageTile(
                        lang['id'], 
                        lang['name'], 
                        lang['flag']
                      )),
                ],
              ),
            ),
          ),
          _buildBottomAction(),
        ],
      ),
    );
  }

  Widget _buildSpeechBubble(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(16),
          bottomRight: Radius.circular(16),
          bottomLeft: Radius.circular(16),
        ),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5, offset: const Offset(0, 2))
        ],
      ),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
    );
  }

  Widget _buildLanguageTile(int id, String title, String assetPath) {
    // Selection logic based on unique ID
    bool isSelected = selectedLanguageId == id;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedLanguageId = id;
          selectedLanguageName = title;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFB2EBF2).withOpacity(0.3) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.primaryBlue : Colors.grey.shade300,
            width: isSelected ? 2.5 : 1,
          ),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.asset(
                assetPath,
                width: 35,
                height: 25,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.flag_outlined),
              ),
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 17, 
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: AppColors.textBlack,
              ),
            ),
            const Spacer(),
            if (isSelected)
              const Icon(Icons.check_circle, color: AppColors.primaryBlue, size: 24),
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
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))],
      ),
      child: ElevatedButton(
        // Button is only active if an ID has been selected
 onPressed: selectedLanguageId == null
                ? null
                : () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>CourseBuildingScreen(
                          languageId: selectedLanguageId!,
                          languageName: selectedLanguageName!,
                        ),
                      ),
                    );
                  },        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryBlue,
          disabledBackgroundColor: Colors.grey.shade300,
          minimumSize: const Size(double.infinity, 56),
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        child: const Text(
          'Continue',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}