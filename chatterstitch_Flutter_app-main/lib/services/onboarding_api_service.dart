import 'dart:convert';
import 'package:http/http.dart' as http;
import 'auth_storage.dart'; // Ensure path is correct

class OnboardingApiService {
  // Use your machine's IP instead of localhost if testing on a physical device
  static const String _baseUrl = 'http://localhost:5000'; 

  static Future<void> saveOnboardingData({
    required int languageId,
    required String proficiencyLevel,
    required List<String> learningReasons,
    required String dailyGoal,
    required bool isPremium,
  }) async {
    try {
      final token = await AuthStorage.getToken();

      if (token == null || token.isEmpty) {
        throw Exception('Authentication required');
      }

      final Map<String, dynamic> body = {
        'language_id': languageId,
        'proficiency_level': proficiencyLevel,
        'learning_reasons': learningReasons,
        'daily_goal': dailyGoal,
        'is_premium': isPremium,
      };

      

      final response = await http.post(
        Uri.parse('$_baseUrl/onboarding/save'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(body),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return; 
      } else if (response.statusCode == 401) {
        throw Exception('Session expired. Please log in again.');
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Connection failed: $e');
    }
  }
}