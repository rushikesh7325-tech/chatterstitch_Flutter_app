import 'dart:convert';
import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../widgets/custom_button.dart'; // Assuming you have this from the login screen
import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // Controllers to capture user input
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isLoading = false;
Future<void> signupUser() async {
  // 1. Validation
  if (_nameController.text.isEmpty || _emailController.text.isEmpty || _passwordController.text.isEmpty) {
    _showError("All fields are required");
    return;
  }

  setState(() => isLoading = true);

  try {
    // 2. The API Call
    final response = await http.post(
      Uri.parse('http://localhost:5000/users/signup'), // Use 10.0.2.2 for Android
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "username": _nameController.text,
        "email": _emailController.text,
        "password": _passwordController.text,
      }),
    );

    // 3. Handling the PostgreSQL result
    if (response.statusCode == 201) {
      if (mounted) Navigator.pushNamed(context, '/intro');
    } else {
      // Handles 400 (Bad Request) or 500 (Server Error)
      final errorData = jsonDecode(response.body);
      _showError(errorData['message'] ?? "Signup failed");
    }
  } catch (e) {
    _showError("Could not connect to server. Check your internet.");
  } finally {
    if (mounted) setState(() => isLoading = false);
  }
}

// Helper for SnackBars
void _showError(String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message), backgroundColor: Colors.redAccent),
  );
}

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
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
          child: Column(
            children: [
              const SizedBox(height: 60),
              Image.asset('assets/images/welcome.png', width: 180),
              const SizedBox(height: 24.0),
              const Text(
                'Create Account',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textBlack,
                ),
              ),
              const SizedBox(height: 32),

              // Name Field
              _buildTextField(
                controller: _nameController,
                hint: 'Full Name',
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 16),

              // Email Field
              _buildTextField(
                controller: _emailController,
                hint: 'Email Address',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),

              // Password Field
              _buildTextField(
                controller: _passwordController,
                hint: 'Password',
                icon: Icons.lock_outline,
                isPassword: true,
              ),
              const SizedBox(height: 32),

              CustomButton(
                text: 'Sign Up',
                onPressed: () {
                  isLoading ? null : signupUser();
                },
              ),

              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? "),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/login'),
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to keep the code clean
  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool isPassword = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
