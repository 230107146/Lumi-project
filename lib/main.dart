import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'core/theme/app_theme.dart';
import 'core/widgets/responsive_wrapper.dart';

// ВАЖНО: Подключаем именно V2 файл
import 'features/landing/landing_page_clean_v2.dart';

// Импорты других экранов (убедись, что эти файлы существуют, иначе удали строки)
import 'features/auth/auth_screen.dart';
import 'features/onboarding/onboarding_screen.dart';
import 'features/home/home_screen.dart';
import 'features/tracker/tracking_screen.dart';
import 'features/analytics/analytics_screen.dart';
import 'features/coach/ai_coach_screen.dart';
import 'features/home/models/habit_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: LumiApp()));
}

class LumiApp extends ConsumerWidget {
  const LumiApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = GoRouter(
      initialLocation: '/',
      routes: [
        // ЛЕНДИНГ (V2)
        GoRoute(
          path: '/',
          builder: (context, state) => const LandingPageV2(),
        ),

        // ПРИЛОЖЕНИЕ
        GoRoute(
          path: '/app',
          builder: (context, state) =>
              const ResponsiveWrapper(child: HomeScreen()),
        ),
        GoRoute(
          path: '/auth',
          builder: (context, state) =>
              const ResponsiveWrapper(child: AuthScreen()),
        ),
        GoRoute(
          path: '/onboarding',
          builder: (context, state) =>
              const ResponsiveWrapper(child: OnboardingScreen()),
        ),
        GoRoute(
          path: '/analytics',
          builder: (context, state) =>
              const ResponsiveWrapper(child: AnalyticsScreen()),
        ),
        GoRoute(
          path: '/coach',
          builder: (context, state) =>
              const ResponsiveWrapper(child: AICoachScreen()),
        ),
        // Трекинг с параметром
        GoRoute(
          path: '/track',
          builder: (context, state) {
            // Безопасное извлечение параметра
            final habit = state.extra is Habit ? state.extra as Habit : null;
            if (habit == null) {
              return const ResponsiveWrapper(child: HomeScreen());
            }
            return ResponsiveWrapper(child: TrackingScreen(habit: habit));
          },
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
