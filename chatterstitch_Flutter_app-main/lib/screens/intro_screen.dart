import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../utils/colors.dart';


class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

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
        // Wrap with SizedBox.expand to ensure it takes up all browser width
        child: SizedBox.expand( 
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              // This ensures children (like buttons) stretch horizontally
              crossAxisAlignment: CrossAxisAlignment.stretch, 
              children: [
                const Spacer(),
                
                // Chat Bubble - Wrapped in Center so the bubble doesn't stretch, 
                // but the Column itself stays wide.
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: const Text(
                      'Hello there, I am Stitch',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textBlack,
                      ),
                    ),
                  ),
                ),
                
                const Icon(Icons.arrow_drop_down, color: Colors.white, size: 30),
                
                Center(
                  child: Image.asset(
                    'assets/images/intro_stitch.png',
                    width: 220,
                  ),
                ),
                
                const Spacer(),
                
                // The CustomButton will now stretch because of crossAxisAlignment.stretch in the Column
                CustomButton(
                  text: 'Continue',
                 onPressed: () {
  Navigator.pushNamed(context, '/questions_intro');
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