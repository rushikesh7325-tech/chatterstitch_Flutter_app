import 'package:flutter/material.dart';
import '../utils/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed; // Added '?' to allow null (disabling the button)
  final bool isSecondary;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isSecondary = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        // 👇 ADD THIS LINE: double.infinity makes it full width
        minimumSize: const Size(double.infinity, 56),

        backgroundColor: isSecondary ? Colors.grey[200] : AppColors.primaryBlue,
        foregroundColor: isSecondary ? AppColors.textBlack : Colors.white,
        elevation: isSecondary ? 0 : 2,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}