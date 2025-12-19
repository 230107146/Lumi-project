import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'core/theme/app_theme.dart';
import 'features/landing/landing_page_clean_v2.dart';
import 'features/auth/auth_screen.dart';
import 'features/onboarding/onboarding_screen.dart';
import 'features/home/home_screen.dart';
import 'features/tracker/tracking_screen.dart';
import 'features/analytics/analytics_screen.dart';
import 'features/coach/ai_coach_screen.dart';
import 'features/profile/profile_screen.dart';
import 'features/home/models/habit_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Инициализация через автоматически сгенерированный файл
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    // ignore: avoid_print
    print('[✅ INFO] Firebase инициализирован успешно');
  } catch (e) {
    // ignore: avoid_print
    print('[⚠️  ERROR] Firebase инициализация не удалась: $e');
    // ignore: avoid_print
    print('[ℹ️  INFO] Приложение продолжит работу без Firebase');
  }

  runApp(const ProviderScope(child: LumiApp()));
}

class LumiApp extends ConsumerWidget {
  const LumiApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const LandingPageV2(),
        ),
        GoRoute(
          path: '/app',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/auth',
          builder: (context, state) => const AuthScreen(),
        ),
        GoRoute(
          path: '/onboarding',
          builder: (context, state) => const OnboardingScreen(),
        ),
        GoRoute(
          path: '/analytics',
          builder: (context, state) => const AnalyticsScreen(),
        ),
        GoRoute(
          path: '/coach',
          builder: (context, state) => const AICoachScreen(),
        ),
        GoRoute(
          path: '/track',
          builder: (context, state) {
            final habit = state.extra is Habit ? state.extra as Habit : null;
            if (habit == null) {
              return const HomeScreen();
            }
            return TrackingScreen(habit: habit);
          },
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfileScreen(),
        ),
      ],
    );

    return MaterialApp.router(
      title: 'LUMI',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: router,
    );
  }
}
