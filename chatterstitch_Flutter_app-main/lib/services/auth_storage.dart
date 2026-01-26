import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthStorage {
  // Using encryptedSharedPreferences for better Android security/compatibility
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );

  static const String _tokenKey = 'jwt_token';
  static const String _onboardingKey = 'onboarding_done';

  static Future<void> saveToken(String token) async {
    try {
      await _storage.write(key: _tokenKey, value: token);
    } catch (e) {
      // Log error (e.g., storage full or hardware issue)
      print("Error saving token: $e");
    }
  }

  static Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  static Future<void> logout() async {
    await _storage.delete(key: _tokenKey);
  }

  // Quick check for the UI to see if we have a session
  static Future<bool> hasToken() async {
    String? token = await getToken();
    return token != null && token.isNotEmpty;
  }
 static Future<void> setOnboardingDone(bool done) async {
    await _storage.write(
      key: _onboardingKey,
      value: done.toString(),
    );
  }

  /// Check onboarding completion
  static Future<bool> isOnboardingDone() async {
    final value = await _storage.read(key: _onboardingKey);
    return value == 'true';
  }
}
