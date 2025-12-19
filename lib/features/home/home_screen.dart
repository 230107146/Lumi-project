import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:lumi/features/home/models/habit_model.dart'; // Убедись, что путь к модели верный

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _activeTab = 'Home';

  // --- MOCK DATA: Список привычек ---
  final List<Habit> _habits = [
    const Habit(
      id: '1',
      title: 'Phone Addiction',
      icon: Icons.smartphone,
      color: Colors.redAccent,
      dailyGoal: 120, // минут
      currentProgress: 95,
      type: AddictionType.timer,
    ),
    const Habit(
      id: '2',
      title: 'Smoking',
      icon: Icons.smoke_free,
      color: Colors.orangeAccent,
      dailyGoal: 5, // сигарет
      currentProgress: 3,
      type: AddictionType.counter,
    ),
    const Habit(
      id: '3',
      title: 'Junk Food',
      icon: Icons.fastfood,
      color: Colors.blueAccent,
      dailyGoal: 3, // приема пищи
      currentProgress: 1,
      type: AddictionType.counter,
    ),
    const Habit(
      id: '4',
      title: 'Gaming',
      icon: Icons.sports_esports,
      color: Colors.purpleAccent,
      dailyGoal: 2, // часа
      currentProgress: 2,
      type: AddictionType.timer,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Получаем ширину экрана
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 900;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),

      // --- ВЕРХНЕЕ МЕНЮ ---
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: _TopNavBar(
          activeTab: _activeTab,
          onTabChanged: (val) {
            setState(() => _activeTab = val);
            if (val == 'Analytics') context.push('/analytics');
            if (val == 'Coach') context.push('/coach');
          },
          isDesktop: isDesktop,
        ),
      ),

      // --- ОСНОВНОЙ КОНТЕНТ ---
      body: SingleChildScrollView(
        padding:
            EdgeInsets.symmetric(vertical: 32, horizontal: isDesktop ? 40 : 24),
        child: Center(
          child: ConstrainedBox(
            // Увеличили ширину до 1400 для полноценного десктопа
            constraints: const BoxConstraints(maxWidth: 1400),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Приветственный баннер
                _WelcomeBanner(isDesktop: isDesktop),

                const SizedBox(height: 48),

                // 2. Заголовок секции
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Your Addictions',
                      style: GoogleFonts.outfit(
                        fontSize: isDesktop ? 32 : 28,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1E1E2E),
                      ),
                    ),
                    if (isDesktop)
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.add, size: 18),
                        label: const Text('Add New'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6C63FF),
                          foregroundColor: Colors.white,
                          elevation: 4,
                          shadowColor:
                              const Color(0xFF6C63FF).withValues(alpha: 0.4),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 18),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14)),
                        ),
                      )
                    else
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6C63FF),
                          foregroundColor: Colors.white,
                          elevation: 4,
                          shadowColor:
                              const Color(0xFF6C63FF).withValues(alpha: 0.4),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14)),
                        ),
                        child: const Icon(Icons.add, size: 16),
                      ),
                  ],
                ),
                const SizedBox(height: 24),

                // 3. АДАПТИВНАЯ СЕТКА КАРТОЧЕК
                LayoutBuilder(
                  builder: (context, constraints) {
                    // Логика колонок:
                    // > 1100px -> 3 колонки
                    // > 700px  -> 2 колонки
                    // < 700px  -> 1 колонка
                    int crossAxisCount = 1;
                    if (constraints.maxWidth > 1100) {
                      crossAxisCount = 3;
                    } else if (constraints.maxWidth > 700) {
                      crossAxisCount = 2;
                    }

                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        // Adjusted for proper card height - desktop: 1.35, mobile: 1.2
                        childAspectRatio: crossAxisCount == 1 ? 1.2 : 1.35,
                        crossAxisSpacing: 24,
                        mainAxisSpacing: 24,
                      ),
                      itemCount: _habits.length,
                      itemBuilder: (context, index) {
                        return _TrackerCard(
                          habit: _habits[index],
                          isDesktop: isDesktop,
                          onTrackPressed: () {
                            context.push('/track', extra: _habits[index]);
                          },
                        );
                      },
                    );
                  },
                ),

                const SizedBox(height: 48),

                // 4. Челлендж дня
                _DailyChallengeCard(isDesktop: isDesktop),

                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
//                               КОМПОНЕНТЫ UI
// -----------------------------------------------------------------------------

class _TopNavBar extends StatelessWidget {
  final String activeTab;
  final Function(String) onTabChanged;
  final bool isDesktop;

  const _TopNavBar({
    required this.activeTab,
    required this.onTabChanged,
    required this.isDesktop,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.8),
        border: Border(
            bottom: BorderSide(color: Colors.grey.withValues(alpha: 0.1))),
      ),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6C63FF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.local_fire_department_rounded,
                      color: Colors.white),
                ),
                const SizedBox(width: 12),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('LUMI',
                        style: GoogleFonts.outfit(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    Text('Wellness Tracker',
                        style: GoogleFonts.inter(
                            fontSize: 12, color: Colors.grey)),
                  ],
                ),
                if (isDesktop) ...[
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: ['Home', 'Analytics', 'Community', 'Coach']
                          .map((tab) {
                        final isActive = activeTab == tab;
                        return InkWell(
                          onTap: () => onTabChanged(tab),
                          borderRadius: BorderRadius.circular(24),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 10),
                            decoration: BoxDecoration(
                              color: isActive
                                  ? const Color(0xFF6C63FF)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: isActive
                                  ? [
                                      BoxShadow(
                                          color: const Color(0xFF6C63FF)
                                              .withValues(alpha: 0.3),
                                          blurRadius: 8,
                                          offset: const Offset(0, 4))
                                    ]
                                  : null,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  _getIcon(tab),
                                  size: 18,
                                  color: isActive
                                      ? Colors.white
                                      : Colors.grey.shade600,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  tab,
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: isActive
                                        ? Colors.white
                                        : Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: Badge(
                    smallSize: 8,
                    child: Icon(Icons.notifications_outlined,
                        color: Colors.grey.shade700),
                  ),
                ),
                const SizedBox(width: 16),
                GestureDetector(
                  onTap: () => context.push('/profile'),
                  child: Container(
                    width: 42,
                    height: 42,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                          colors: [Color(0xFF6C63FF), Color(0xFF8B85FF)]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData _getIcon(String tab) {
    switch (tab) {
      case 'Home':
        return Icons.home_rounded;
      case 'Analytics':
        return Icons.bar_chart_rounded;
      case 'Community':
        return Icons.people_outline_rounded;
      case 'Coach':
        return Icons.chat_bubble_outline_rounded;
      default:
        return Icons.circle;
    }
  }
}

class _WelcomeBanner extends StatelessWidget {
  final bool isDesktop;

  const _WelcomeBanner({required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    final bannerPadding = isDesktop ? 40.0 : 24.0;
    final titleFontSize = isDesktop ? 48.0 : 32.0;
    final subtitleFontSize = isDesktop ? 24.0 : 18.0;
    final streakFontSize = isDesktop ? 20.0 : 16.0;
    final iconSize = isDesktop ? 32.0 : 24.0;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(bannerPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        gradient: const LinearGradient(
          colors: [Color(0xFF6C63FF), Color(0xFF8B85FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6C63FF).withValues(alpha: 0.3),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: isDesktop
          ? Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Good Morning',
                        style: GoogleFonts.outfit(
                          fontSize: titleFontSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 1.1,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Alex',
                        style: GoogleFonts.inter(
                          fontSize: subtitleFontSize,
                          color: Colors.white.withValues(alpha: 0.9),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                    border:
                        Border.all(color: Colors.white.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.local_fire_department_rounded,
                          color: Colors.orangeAccent, size: iconSize),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('7 Day Streak',
                              style: GoogleFonts.inter(
                                  color: Colors.white70, fontSize: 12)),
                          Text('Keep going!',
                              style: GoogleFonts.outfit(
                                  color: Colors.white,
                                  fontSize: streakFontSize,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Good Morning',
                            style: GoogleFonts.outfit(
                              fontSize: titleFontSize,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              height: 1.1,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Alex',
                            style: GoogleFonts.inter(
                              fontSize: subtitleFontSize,
                              color: Colors.white.withValues(alpha: 0.9),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(16),
                    border:
                        Border.all(color: Colors.white.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.local_fire_department_rounded,
                          color: Colors.orangeAccent, size: iconSize),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('7 Day Streak',
                              style: GoogleFonts.inter(
                                  color: Colors.white70, fontSize: 11)),
                          Text('Keep going!',
                              style: GoogleFonts.outfit(
                                  color: Colors.white,
                                  fontSize: streakFontSize,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

class _TrackerCard extends StatelessWidget {
  final Habit habit;
  final bool isDesktop;
  final VoidCallback onTrackPressed;

  const _TrackerCard({
    required this.habit,
    required this.isDesktop,
    required this.onTrackPressed,
  });

  @override
  Widget build(BuildContext context) {
    double progress =
        habit.dailyGoal > 0 ? (habit.currentProgress / habit.dailyGoal) : 0.0;
    if (progress > 1.0) progress = 1.0;

    final cardPadding = isDesktop ? 32.0 : 20.0;
    final titleFontSize = isDesktop ? 22.0 : 18.0;
    final subtitleFontSize = isDesktop ? 14.0 : 12.0;
    final percentFontSize = isDesktop ? 16.0 : 14.0;

    return Container(
      padding: EdgeInsets.all(cardPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: habit.color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(habit.icon,
                    color: habit.color, size: isDesktop ? 24 : 20),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.local_fire_department,
                        color: Colors.orange, size: 14),
                    const SizedBox(width: 4),
                    Text("5 days",
                        style: GoogleFonts.inter(
                            fontSize: 11, fontWeight: FontWeight.w600)),
                  ],
                ),
              )
            ],
          ),
          const Spacer(),
          Text(habit.title,
              style: GoogleFonts.outfit(
                  fontSize: titleFontSize, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(
            habit.type == AddictionType.timer
                ? '${habit.currentProgress} / ${habit.dailyGoal} mins'
                : '${habit.currentProgress} / ${habit.dailyGoal} units',
            style: GoogleFonts.inter(
                fontSize: subtitleFontSize, color: Colors.grey),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 8,
                    backgroundColor: Colors.grey.shade100,
                    valueColor: AlwaysStoppedAnimation(habit.color),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text('${(progress * 100).toInt()}%',
                  style: GoogleFonts.outfit(
                      fontSize: percentFontSize, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onTrackPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6C63FF),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: isDesktop ? 16 : 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
                elevation: 0,
              ),
              child: Text('Track Now',
                  style: GoogleFonts.inter(
                      fontSize: isDesktop ? 14 : 13,
                      fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }
}

class _DailyChallengeCard extends StatelessWidget {
  final bool isDesktop;

  const _DailyChallengeCard({required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    final cardPadding = isDesktop ? 40.0 : 24.0;
    final titleFontSize = isDesktop ? 24.0 : 18.0;
    final descFontSize = isDesktop ? 18.0 : 14.0;
    final iconSize = isDesktop ? 32.0 : 24.0;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(cardPadding),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.orange, Colors.amber],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: isDesktop
          ? Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.flag, color: Colors.white, size: iconSize),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Today's Challenge",
                        style: GoogleFonts.outfit(
                            fontSize: titleFontSize,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Go 2 hours without checking your phone. You can do it! 💪",
                        style: GoogleFonts.inter(
                            fontSize: descFontSize,
                            color: Colors.white.withValues(alpha: 0.9)),
                      ),
                    ],
                  ),
                )
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.flag, color: Colors.white, size: iconSize),
                ),
                const SizedBox(height: 16),
                Text(
                  "Today's Challenge",
                  style: GoogleFonts.outfit(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(height: 8),
                Text(
                  "Go 2 hours without checking your phone. You can do it! 💪",
                  style: GoogleFonts.inter(
                      fontSize: descFontSize,
                      color: Colors.white.withValues(alpha: 0.9)),
                ),
              ],
            ),
    );
  }
}
