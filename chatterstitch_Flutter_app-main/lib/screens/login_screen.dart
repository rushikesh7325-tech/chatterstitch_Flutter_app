import 'package:chatter_stitch_onboarding/utils/colors.dart';
import 'package:chatter_stitch_onboarding/widgets/custom_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../services/auth_storage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isLoading = false;

  // Inside _LoginScreenState

  Future<void> loginuser() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text; // Don't trim passwords!

    if (username.isEmpty || password.isEmpty) {
      _showError("All fields are required");
      return;
    }

    setState(() => isLoading = true);

    try {
      final response = await http
          .post(
            // Change 'localhost' to '10.0.2.2' for Android Emulator
            Uri.parse('http://localhost:5000/users/login'),
            headers: const {'Content-Type': 'application/json'},
            body: jsonEncode({"username": username, "password": password}),
          )
          .timeout(const Duration(seconds: 10)); // Add a timeout!

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final String? token = data['token'];
        final bool onboardingDone = data['is_onboarding_completed'] ?? false;

        if (token != null) {
          await AuthStorage.saveToken(token);
          await AuthStorage.setOnboardingDone(onboardingDone);

          if (mounted) {
            // Decide destination based on onboarding status
            String nextRoute = onboardingDone ? '/final_score' : '/intro';

            Navigator.pushNamedAndRemoveUntil(
              context,
              nextRoute,
              (route) => false,
            );
          }
        }
      } else {
        // Safely access the message key from your backend response
        _showError(data['message'] ?? "Login failed");
      }
    } catch (e) {
      _showError("Connection failed. Please check your internet or server.");
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.redAccent),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          // Using a ConstrainedBox ensures the content fills the screen
          // while still allowing scrolling if needed.
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 80),
              Image.asset('assets/images/welcome.png', width: 220),
              const SizedBox(height: 24),
              const Text(
                'ChatterStitch',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textBlack,
                ),
              ),
              const SizedBox(height: 32),

              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  hintText: 'Enter Username',
                  prefixIcon: const Icon(Icons.person_outline),
                  filled: true, // Adds a subtle background to the input
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none, // Clean, modern look
                  ),
                ),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Enter Password',
                  prefixIcon: const Icon(Icons.lock_outline),
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              isLoading
                  ? const CircularProgressIndicator(color: Colors.blueAccent)
                  : CustomButton(
                      text: 'Login',
                      onPressed: () {
                        // Call the login logic instead of direct navigation
                        loginuser();
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
