import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/welcome_screen.dart';
import 'screens/intro_screen.dart';
import 'screens/questions_intro_screen.dart'; // 1. Add this import
import 'screens/language_selection_screen.dart'; // 1. Add this import
import 'screens/proficiency_level_screen.dart';
import 'screens/course_building_screen.dart';
import 'screens/learning_reason_screen.dart';
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ChatterStitch',
      initialRoute: '/',
      // Inside lib/app.dart
routes: {
  '/': (context) => const SplashScreen(),
  '/welcome': (context) => const WelcomeScreen(),
  '/intro': (context) => const IntroScreen(),
  '/questions_intro': (context) => const QuestionsIntroScreen(),
  '/select_language': (context) => const LanguageSelectionScreen(),
  

'/course_building': (context) {
  // Use 'as String?' and the ?? operator to provide a default
  final String? language = ModalRoute.of(context)?.settings.arguments as String?;
  return CourseBuildingScreen(selectedLanguage: language ?? 'French'); 
},

'/proficiency': (context) {
  final String? language = ModalRoute.of(context)?.settings.arguments as String?;
  return ProficiencyLevelScreen(selectedLanguage: language ?? 'French');
},
'/learning_reason': (context) {
  final String language = ModalRoute.of(context)!.settings.arguments as String;
  return LearningReasonScreen(selectedLanguage: language);
},
},
    );
  }
}