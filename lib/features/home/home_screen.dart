import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../core/services/auth_service.dart';

import 'models/habit_model.dart';
import 'package:go_router/go_router.dart';
import '../../core/widgets/responsive_wrapper.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  List<Habit> get dummyHabits => const [
        Habit(
          id: 'h1',
          title: 'Alcohol',
          icon: Icons.local_bar,
          color: Colors.pinkAccent,
          dailyGoal: 1,
          currentProgress: 0,
          type: AddictionType.counter,
        ),
        Habit(
          id: 'h2',
          title: 'Smoking',
          icon: Icons.smoking_rooms,
          color: Colors.orangeAccent,
          dailyGoal: 10,
          currentProgress: 5,
          type: AddictionType.counter,
        ),
        Habit(
          id: 'h3',
          title: 'Junk Food',
          icon: Icons.fastfood,
          color: Colors.blueAccent,
          dailyGoal: 3,
          currentProgress: 1,
          type: AddictionType.counter,
        ),
        Habit(
          id: 'h4',
          title: 'Gaming',
          icon: Icons.sports_esports,
          color: Colors.purpleAccent,
          dailyGoal: 4,
          currentProgress: 2,
          type: AddictionType.timer,
        ),
      ];

  double _overallProgress(List<Habit> habits) {
    final totalGoal = habits.fold<int>(0, (s, h) => s + (h.dailyGoal));
    final totalDone = habits.fold<int>(0, (s, h) => s + (h.currentProgress));
    if (totalGoal == 0) return 0.0;
    return (totalDone / totalGoal).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final habits = dummyHabits;
    final overall = _overallProgress(habits);
    // Save last route for returning user
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // best-effort save (async not awaited intentionally)
      AuthService.saveLastRoute('/app');
    });

    return ResponsiveWrapper(
      child: Scaffold(
        backgroundColor: theme.colorScheme.surface,
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.push('/coach'),
          backgroundColor: AppColors.primary,
          child: const Icon(Icons.chat_bubble),
        ),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                sliver: SliverToBoxAdapter(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Good Morning, User!',
                                style: theme.textTheme.headlineSmall
                                    ?.copyWith(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 6),
                            Text("Let's make today count.",
                                style: theme.textTheme.bodyMedium
                                    ?.copyWith(color: Colors.grey.shade600)),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.local_fire_department,
                                  color: Colors.orangeAccent),
                              const SizedBox(width: 6),
                              Text('5 Day Streak',
                                  style: theme.textTheme.bodyMedium
                                      ?.copyWith(fontWeight: FontWeight.w600)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          TextButton.icon(
                            onPressed: () => context.push('/analytics'),
                            icon: const Icon(Icons.show_chart, size: 18),
                            label: const Text('View Analytics'),
                            style: TextButton.styleFrom(
                                foregroundColor: AppColors.primary),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Progress Card
              SliverPadding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                sliver: SliverToBoxAdapter(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF6C63FF), Color(0xFF8B85FF)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: const Color(0x14000000),
                            blurRadius: 12,
                            offset: const Offset(0, 6)),
                      ],
                    ),
                    padding: const EdgeInsets.all(20),
                    height: 200,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Daily Goals',
                                  style: theme.textTheme.titleLarge?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 8),
                              Text('You are doing great! Keep it up.',
                                  style: theme.textTheme.bodyMedium
                                      ?.copyWith(color: Colors.white70)),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        SizedBox(
                          width: 110,
                          height: 110,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                width: 110,
                                height: 110,
                                child: CircularProgressIndicator(
                                  value: overall,
                                  strokeWidth: 8,
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                          Colors.white),
                                  backgroundColor: Colors.white24,
                                ),
                              ),
                              Text('${(overall * 100).round()}%',
                                  style: theme.textTheme.titleLarge?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Section title
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                sliver: SliverToBoxAdapter(
                  child: Text('My Trackers',
                      style: theme.textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w700)),
                ),
              ),

              // Habits grid
              SliverPadding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final habit = habits[index];
                    final progress = habit.dailyGoal > 0
                        ? (habit.currentProgress / habit.dailyGoal)
                            .clamp(0.0, 1.0)
                        : 0.0;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          // Open tracking screen for this habit
                          context.push('/track', extra: habit);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: CircleAvatar(
                                  backgroundColor: habit.color.withAlpha(41),
                                  child: Icon(habit.icon, color: habit.color),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Flexible(
                                child: Text(habit.title,
                                    style: theme.textTheme.titleSmall?.copyWith(
                                        fontWeight: FontWeight.w600)),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Expanded(
                                    child: LinearProgressIndicator(
                                        value: progress,
                                        color: AppColors.primary,
                                        backgroundColor: Colors.grey.shade200),
                                  ),
                                  const SizedBox(width: 8),
                                  IconButton(
                                    onPressed: () {
                                      // open tracker for this habit
                                      context.push('/track', extra: habit);
                                    },
                                    icon: const Icon(Icons.add_circle_outline),
                                    color: AppColors.primary,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                  '${habit.currentProgress}/${habit.dailyGoal}',
                                  style: theme.textTheme.bodySmall
                                      ?.copyWith(color: Colors.grey.shade600)),
                            ],
                          ),
                        ),
                      ),
                    );
                  }, childCount: habits.length),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 220,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.85,
                  ),
                ),
              ),
              const SliverPadding(padding: EdgeInsets.only(bottom: 40)),
            ],
          ),
        ),
      ),
    );
  }
}
