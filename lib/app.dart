import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/welcome_screen.dart';
import 'screens/intro_screen.dart';
import 'screens/questions_intro_screen.dart'; // 1. Add this import
import 'screens/language_selection_screen.dart'; // 1. Add this import
import 'screens/proficiency_level_screen.dart';
import 'screens/course_building_screen.dart';
import 'screens/learning_reason_screen.dart';
import 'screens/routine_intro_screen.dart';
import 'screens/daily_goal_screen.dart';
import 'screens/goal_confirmation_screen.dart';
import 'screens/notifications_intro_screen.dart';
import 'screens/widget_intro_screen.dart';
import 'screens/achievements_summary_screen.dart';
import 'screens/subscription_screen.dart';
import 'screens/start_point_screen.dart';
import 'screens/final_score_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ChatterStitch',
      initialRoute: '/',

      // Inside lib/app.dart
      // lib/app.dart
      routes: {
        '/': (context) => const SplashScreen(),
        '/welcome': (context) => const WelcomeScreen(),
        '/intro': (context) => const IntroScreen(),
        '/questions_intro': (context) => const QuestionsIntroScreen(),
        '/select_language': (context) => const LanguageSelectionScreen(),

        // 1. Transition Screen
        '/course_building': (context) {
          final String? lang =
              ModalRoute.of(context)?.settings.arguments as String?;
          return CourseBuildingScreen(selectedLanguage: lang ?? 'English');
        },

        // 2. Proficiency Screen
        '/proficiency': (context) {
          final String? lang =
              ModalRoute.of(context)?.settings.arguments as String?;
          return ProficiencyLevelScreen(selectedLanguage: lang ?? 'English');
        },

        // 3. Learning Reason Screen (The one you just added)
        '/learning_reason': (context) {
          final String? lang =
              ModalRoute.of(context)?.settings.arguments as String?;
          return LearningReasonScreen(selectedLanguage: lang ?? 'English');
        },
        '/routine_intro': (context) {
          final String? lang =
              ModalRoute.of(context)?.settings.arguments as String?;
          return RoutineIntroScreen(selectedLanguage: lang ?? 'English');
        },
        '/daily_goal': (context) {
          final String? lang =
              ModalRoute.of(context)?.settings.arguments as String?;
          return DailyGoalScreen(selectedLanguage: lang ?? 'English');
        },
        '/goal_confirmation': (context) {
          final String? lang =
              ModalRoute.of(context)?.settings.arguments as String?;
          return GoalConfirmationScreen(selectedLanguage: lang ?? 'English');
        },
        '/notifications_intro': (context) {
          final String? lang =
              ModalRoute.of(context)?.settings.arguments as String?;
          return NotificationsIntroScreen(selectedLanguage: lang ?? 'English');
        },
        '/widget_intro': (context) {
          final String? lang =
              ModalRoute.of(context)?.settings.arguments as String?;
          return WidgetIntroScreen(selectedLanguage: lang ?? 'English');
        },
        '/achievements_summary': (context) {
          final String? lang =
              ModalRoute.of(context)?.settings.arguments as String?;
          return AchievementsSummaryScreen(selectedLanguage: lang ?? 'English');
        },
        '/subscription': (context) {
          final String? lang =
              ModalRoute.of(context)?.settings.arguments as String?;
          return SubscriptionScreen(selectedLanguage: lang ?? 'French');
        },
        '/start_point': (context) {
          final String? lang =
              ModalRoute.of(context)?.settings.arguments as String?;
          return StartPointScreen(selectedLanguage: lang ?? 'French');
        },
       '/final_score': (context) => const FinalScoreScreen(), 
        // The new destination
      },
    );
  }
}
