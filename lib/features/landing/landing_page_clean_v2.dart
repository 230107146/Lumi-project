import 'dart:ui';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lumi/core/theme/app_theme.dart';
// Если AuthService нет или он вызывает ошибку, закомментируй импорт и используй заглушку
import 'package:lumi/core/services/auth_service.dart';
import 'widgets/floating_ai_chat.dart';

class LandingPageV2 extends StatefulWidget {
  const LandingPageV2({super.key});

  @override
  State<LandingPageV2> createState() => _LandingPageV2State();
}

class _LandingPageV2State extends State<LandingPageV2> {
  late bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    try {
      final loggedIn = AuthService.isLoggedIn();
      if (mounted) {
        setState(() {
          _isLoggedIn = loggedIn;
        });
      }
    } catch (e) {
      // If AuthService fails, default to false (guest)
      if (mounted) {
        setState(() {
          _isLoggedIn = false;
        });
      }
    }
  }

  // Заглушка, если AuthService не работает
  Future<void> _handleStartTracking() async {
    // Если AuthService дает ошибку, просто пиши: context.push('/auth');
    try {
      final loggedIn = AuthService.isLoggedIn();
      if (!mounted) return;
      if (loggedIn) {
        context.push('/app');
      } else {
        context.push('/auth');
      }
    } catch (e) {
      context.push('/auth');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const _LandingDrawer(),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // --- СЛОЙ 0: ФОНОВЫЕ ПЯТНА (AMBIENT BLOBS) ---
          Positioned(
            top: -100,
            left: -100,
            child: _AmbientBlob(
              color: const Color(0xFF6C63FF).withValues(alpha: 0.25),
            ),
          ),
          Positioned(
            bottom: -100,
            right: -100,
            child: _AmbientBlob(
              color: const Color(0xFF2563EB).withValues(alpha: 0.2),
            ),
          ),

          // --- СЛОЙ 1: ОСНОВНОЙ КОНТЕНТ ---
          Positioned.fill(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 76),

                  // HERO SECTION
                  Container(
                    constraints: BoxConstraints(minHeight: screenHeight * 0.9),
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    width: double.infinity,
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1200),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            final isWide = constraints.maxWidth > 900;
                            return Row(
                              children: [
                                // Text Content
                                Expanded(
                                  flex: 6,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color: const Color(
                                            0xFF6C63FF,
                                          ).withValues(alpha: 0.1),
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          border: Border.all(
                                            color: const Color(
                                              0xFF6C63FF,
                                            ).withValues(alpha: 0.2),
                                          ),
                                        ),
                                        child: Text(
                                          'AI-Powered Recovery',
                                          style: GoogleFonts.inter(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFF6C63FF),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 24),
                                      RichText(
                                        text: TextSpan(
                                          style: isWide
                                              ? GoogleFonts.outfit(
                                                  fontSize: 64,
                                                  fontWeight: FontWeight.w700,
                                                  height: 1.1,
                                                  color: const Color(
                                                    0xFF111111,
                                                  ),
                                                )
                                              : GoogleFonts.outfit(
                                                  fontSize: 42,
                                                  fontWeight: FontWeight.w700,
                                                  height: 1.1,
                                                  color: const Color(
                                                    0xFF111111,
                                                  ),
                                                ),
                                          children: [
                                            const TextSpan(
                                              text: 'Quit Bad Habits.\n',
                                            ),
                                            WidgetSpan(
                                              child: _GradientText(
                                                'Start Living.',
                                                style: isWide
                                                    ? GoogleFonts.outfit(
                                                        fontSize: 64,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        height: 1.1,
                                                      )
                                                    : GoogleFonts.outfit(
                                                        fontSize: 42,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        height: 1.1,
                                                      ),
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Color(0xFF6C63FF),
                                                    Color(0xFF2563EB),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 24),
                                      Text(
                                        'AI-powered tracker for alcohol, smoking, and gaming addiction. Get personalized insights, real-time support, and measurable progress.',
                                        style: GoogleFonts.inter(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                          height: 1.6,
                                          color: const Color(0xFF555555),
                                        ),
                                      ),
                                      const SizedBox(height: 32),
                                      Row(
                                        children: [
                                          _GradientButton(
                                            onPressed: _handleStartTracking,
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: const [
                                                Text(
                                                  'Start Tracking Now',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                SizedBox(width: 8),
                                                Icon(
                                                  Icons.arrow_forward_rounded,
                                                  color: Colors.white,
                                                  size: 20,
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 16),
                                          _OutlineCTA(
                                            onPressed: () =>
                                                context.push('/auth'),
                                            child: const Text(
                                              'Watch Demo',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xFF111111),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 40),
                                      // Stats
                                      Row(
                                        children: const [
                                          _StatItem(
                                            value: '50K+',
                                            label: 'Active Users',
                                          ),
                                          SizedBox(width: 24),
                                          _StatItem(
                                            value: '87%',
                                            label: 'Success Rate',
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                if (isWide) const SizedBox(width: 40),
                                if (isWide)
                                  Expanded(
                                    flex: 5,
                                    child: Center(
                                      // ЛЕВИТИРУЮЩАЯ КАРТОЧКА - динамически меняется в зависимости от статуса
                                      child: _isLoggedIn
                                          ? const _FloatingHeroCard()
                                          : const _GuestHeroCard(),
                                    ),
                                  ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),

                  // FEATURES SECTION
                  Container(
                    color: Colors.white.withValues(alpha: 0.4),
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 80,
                      horizontal: 24,
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1100),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Powerful Features Built for Recovery',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.outfit(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF111111),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Everything you need to track, understand, and overcome addiction patterns.',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                fontSize: 18,
                                color: const Color(0xFF666666),
                              ),
                            ),
                            const SizedBox(height: 60),
                            Wrap(
                              spacing: 24,
                              runSpacing: 24,
                              alignment: WrapAlignment.center,
                              children: const [
                                _FeatureTile(
                                  emoji: '🧠',
                                  title: 'AI Insights',
                                  subtitle:
                                      'Get personalized recommendations based on your patterns',
                                ),
                                _FeatureTile(
                                  emoji: '⚡',
                                  title: 'Real-Time Tracking',
                                  subtitle:
                                      'Log cravings and victories instantly with one tap',
                                ),
                                _FeatureTile(
                                  emoji: '🤝',
                                  title: 'Community Support',
                                  subtitle:
                                      'Connect with thousands overcoming similar challenges',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // HOW IT WORKS SECTION
                  const SizedBox(height: 80),
                  const _HowItWorksSection(),
                  const SizedBox(height: 80),

                  // TRUST & REVIEWS SECTION
                  const _TrustSection(),
                  const SizedBox(height: 80),

                  // CTA BANNER SECTION
                  const _CTABanner(),
                  const SizedBox(height: 80),

                  // FOOTER (MINIMALIST COMPACT)
                  Container(
                    color: const Color(0xFF111111), // Modern Dark
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 40,
                      horizontal: 24,
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1200),
                        child: Column(
                          children: [
                            // --- MAIN FOOTER CONTENT (4 COLUMNS) ---
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // COL 1: BRAND
                                SizedBox(
                                  width: 250,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(6),
                                            decoration: BoxDecoration(
                                              gradient: const LinearGradient(
                                                colors: [
                                                  Color(0xFF6C63FF),
                                                  Color(0xFF2563EB),
                                                ],
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                            child: const Icon(
                                              Icons.spa_rounded,
                                              color: Colors.white,
                                              size: 16,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            'LUMI',
                                            style: GoogleFonts.outfit(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 12),
                                      Text(
                                        'AI-powered wellness tracking for modern minds',
                                        style: GoogleFonts.inter(
                                          fontSize: 13,
                                          color: Colors.white70,
                                          height: 1.4,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 60),

                                // COL 2: PRODUCT
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Product',
                                        style: GoogleFonts.outfit(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      _FooterLink('Features'),
                                      const SizedBox(height: 10),
                                      _FooterLink('Pricing'),
                                      const SizedBox(height: 10),
                                      _FooterLink('Download'),
                                    ],
                                  ),
                                ),

                                // COL 3: COMPANY
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Company',
                                        style: GoogleFonts.outfit(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      _FooterLink('About'),
                                      const SizedBox(height: 10),
                                      _FooterLink('Blog'),
                                      const SizedBox(height: 10),
                                      _FooterLink('Legal'),
                                    ],
                                  ),
                                ),

                                // COL 4: CONTACT
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Get in touch',
                                        style: GoogleFonts.outfit(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.mail_outline_rounded,
                                            color: Colors.white54,
                                            size: 16,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            'hello@lumi.app',
                                            style: GoogleFonts.inter(
                                              fontSize: 13,
                                              color: Colors.white70,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            // --- DIVIDER ---
                            const SizedBox(height: 20),
                            Divider(
                              color: Colors.white12,
                              height: 1,
                              thickness: 0.5,
                            ),

                            // --- FOOTER BOTTOM (COPYRIGHT + SOCIALS) ---
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '© 2025 LUMI. All rights reserved.',
                                  style: GoogleFonts.inter(
                                    color: Colors.white38,
                                    fontSize: 12,
                                  ),
                                ),
                                Row(
                                  children: [
                                    _SocialIcon(Icons.language_rounded),
                                    const SizedBox(width: 16),
                                    _SocialIcon(Icons.favorite_border_rounded),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // --- СЛОЙ 2: ПЛАВАЮЩИЙ ЧАТ ---
          Positioned(
            right: 20,
            bottom: 20,
            child: SafeArea(
              child: SizedBox(width: 360, child: const FloatingAiChat()),
            ),
          ),

          // --- СЛОЙ 3: ХЕДЕР (PINNED) ---
          const Positioned(top: 0, left: 0, right: 0, child: _LandingHeader()),
        ],
      ),
    );
  }
}

// ----------------------------------------------------------------------
//                          HELPER WIDGETS
// ----------------------------------------------------------------------

class _AmbientBlob extends StatelessWidget {
  final Color color;
  const _AmbientBlob({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      height: 500,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 120, sigmaY: 120),
        child: Container(color: Colors.transparent),
      ),
    );
  }
}

class _GradientText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Gradient gradient;

  const _GradientText(this.text, {required this.style, required this.gradient});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}

class _FloatingHeroCard extends StatefulWidget {
  const _FloatingHeroCard();

  @override
  State<_FloatingHeroCard> createState() => _FloatingHeroCardState();
}

class _FloatingHeroCardState extends State<_FloatingHeroCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final offset = math.sin(_controller.value * 2 * math.pi) * 10;
        return Transform.translate(offset: Offset(0, offset), child: child);
      },
      child: Container(
        width: 320,
        height: 400,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.7),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.8),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF6C63FF).withValues(alpha: 0.15),
              blurRadius: 40,
              offset: const Offset(0, 20),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Today's Progress",
                  style: GoogleFonts.outfit(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF6C63FF), Color(0xFF2563EB)],
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.bar_chart,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Streak", style: GoogleFonts.inter(color: Colors.grey)),
                Text(
                  "42 days",
                  style: GoogleFonts.outfit(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF6C63FF),
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: const LinearProgressIndicator(
                value: 0.8,
                minHeight: 8,
                backgroundColor: Color(0xFFEEEEEE),
                valueColor: AlwaysStoppedAnimation(Color(0xFF6C63FF)),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Weekly Goal",
                  style: GoogleFonts.inter(color: Colors.grey),
                ),
                Text(
                  "85%",
                  style: GoogleFonts.outfit(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF2563EB),
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: const LinearProgressIndicator(
                value: 0.85,
                minHeight: 8,
                backgroundColor: Color(0xFFEEEEEE),
                valueColor: AlwaysStoppedAnimation(Color(0xFF2563EB)),
              ),
            ),
            const Spacer(),
            Center(
              child: Text(
                "You're in the top 5% of users",
                style: GoogleFonts.inter(fontSize: 12, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GuestHeroCard extends StatefulWidget {
  const _GuestHeroCard();

  @override
  State<_GuestHeroCard> createState() => _GuestHeroCardState();
}

class _GuestHeroCardState extends State<_GuestHeroCard>
    with TickerProviderStateMixin {
  late final AnimationController _floatController;
  late final AnimationController _heatmapController;

  @override
  void initState() {
    super.initState();
    // Floating animation (4 seconds)
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    // Heatmap bars animation (1.2 seconds, staggered)
    _heatmapController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1200),
    )..forward();
  }

  @override
  void dispose() {
    _floatController.dispose();
    _heatmapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get current day of week (1 = Monday, 7 = Sunday)
    final today = DateTime.now().weekday;

    return AnimatedBuilder(
      animation: _floatController,
      builder: (context, child) {
        final offset = math.sin(_floatController.value * 2 * math.pi) * 10;
        return Transform.translate(offset: Offset(0, offset), child: child);
      },
      child: Container(
        width: 320,
        height: 420,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.7),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.8),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF6C63FF).withValues(alpha: 0.15),
              blurRadius: 40,
              offset: const Offset(0, 20),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Your Personal Growth Hub",
                  style: GoogleFonts.outfit(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF6C63FF), Color(0xFF2563EB)],
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.local_fire_department,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Weekly Streak Indicator
            _WeeklyStreakIndicator(todayIndex: today),

            const SizedBox(height: 12),

            // Activity Heatmap
            _ActivityHeatmap(controller: _heatmapController),

            const SizedBox(height: 4),

            // Feature 1: Track Streaks (Compact)
            _CompactFeatureItem(
              emoji: "🔥",
              title: "Track Streaks",
              subtitle: "Monitor progress",
              bgColor: const Color(0xFF6C63FF),
            ),
            const SizedBox(height: 8),

            // Feature 2: AI Insights (Compact)
            _CompactFeatureItem(
              emoji: "🧠",
              title: "AI Insights",
              subtitle: "Personalized tips",
              bgColor: const Color(0xFF2563EB),
            ),
            const SizedBox(height: 8),

            // Feature 3: Private & Secure (Compact)
            _CompactFeatureItem(
              emoji: "🔒",
              title: "Private & Secure",
              subtitle: "Data protected",
              bgColor: const Color(0xFF10B981),
            ),

            const Spacer(),

            // Call to action text
            Center(
              child: Text(
                "Join thousands building better habits",
                style: GoogleFonts.inter(fontSize: 11, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WeeklyStreakIndicator extends StatelessWidget {
  final int todayIndex;

  const _WeeklyStreakIndicator({required this.todayIndex});

  @override
  Widget build(BuildContext context) {
    final dayLabels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'This Week',
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(7, (index) {
            final dayNumber = index + 1; // 1-7 for Monday-Sunday
            final isToday = dayNumber == todayIndex;

            return Container(
              width: isToday ? 32 : 28,
              height: isToday ? 32 : 28,
              decoration: BoxDecoration(
                gradient: isToday
                    ? const LinearGradient(
                        colors: [Color(0xFF6C63FF), Color(0xFF2563EB)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : null,
                color: isToday ? null : Colors.grey[200],
                borderRadius: BorderRadius.circular(isToday ? 10 : 8),
                boxShadow: isToday
                    ? [
                        BoxShadow(
                          color:
                              const Color(0xFF6C63FF).withValues(alpha: 0.35),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ]
                    : null,
              ),
              child: Center(
                child: Text(
                  dayLabels[index],
                  style: GoogleFonts.outfit(
                    fontSize: isToday ? 12 : 11,
                    fontWeight: isToday ? FontWeight.w700 : FontWeight.w600,
                    color: isToday ? Colors.white : Colors.grey[600],
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class _ActivityHeatmap extends StatelessWidget {
  final AnimationController controller;

  const _ActivityHeatmap({required this.controller});

  @override
  Widget build(BuildContext context) {
    // Mock data: activity levels for 7 days (0-1)
    final activityLevels = [0.6, 0.8, 0.5, 0.9, 0.7, 0.95, 0.4];
    final maxHeight = 50.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Activity',
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: maxHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(7, (index) {
              // Staggered animation for each bar
              final staggerDelay = index * 0.15; // 150ms between bars
              final delayedValue = (controller.value - staggerDelay).clamp(
                0.0,
                1.0,
              );

              // Animate from 0 to full height
              final barHeight =
                  maxHeight * activityLevels[index] * delayedValue;

              // Color gradient: light purple to dark purple
              final colorValue = activityLevels[index];
              final barColor = Color.lerp(
                const Color(0xFFE9D5FF), // Light purple
                const Color(0xFF6C63FF), // Full purple
                colorValue,
              )!;

              return Flexible(
                child: Container(
                  width: 4,
                  height: barHeight,
                  decoration: BoxDecoration(
                    color: barColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}

class _CompactFeatureItem extends StatelessWidget {
  final String emoji;
  final String title;
  final String subtitle;
  final Color bgColor;

  const _CompactFeatureItem({
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: bgColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(emoji, style: const TextStyle(fontSize: 18)),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
              Text(
                subtitle,
                style: GoogleFonts.inter(fontSize: 11, color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FeatureTile extends StatefulWidget {
  final String emoji;
  final String title;
  final String subtitle;

  const _FeatureTile({
    required this.emoji,
    required this.title,
    required this.subtitle,
  });

  @override
  State<_FeatureTile> createState() => _FeatureTileState();
}

class _FeatureTileState extends State<_FeatureTile> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 340,
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: _hover
              ? Colors.white.withValues(alpha: 0.8)
              : Colors.white.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: _hover
                ? const Color(0xFF6C63FF).withValues(alpha: 0.3)
                : Colors.white.withValues(alpha: 0.5),
          ),
          boxShadow: [
            if (_hover)
              BoxShadow(
                color: const Color(0xFF6C63FF).withValues(alpha: 0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.emoji, style: const TextStyle(fontSize: 40)),
            const SizedBox(height: 16),
            Text(
              widget.title,
              style: GoogleFonts.outfit(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF111111),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.subtitle,
              style: GoogleFonts.inter(
                fontSize: 15,
                height: 1.5,
                color: const Color(0xFF666666),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: GoogleFonts.outfit(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF6C63FF),
          ),
        ),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14,
            color: const Color(0xFF555555),
          ),
        ),
      ],
    );
  }
}

class _LandingHeader extends StatefulWidget {
  const _LandingHeader();
  @override
  State<_LandingHeader> createState() => _LandingHeaderState();
}

class _LandingHeaderState extends State<_LandingHeader> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.7),
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withValues(alpha: 0.5),
                width: 1,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isDesktop = constraints.maxWidth >= 900;
                if (!isDesktop) {
                  return Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF6C63FF), Color(0xFF2563EB)],
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.spa_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'LUMI',
                        style: GoogleFonts.outfit(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.menu),
                        onPressed: () => Scaffold.of(context).openDrawer(),
                      ),
                    ],
                  );
                }

                return Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF6C63FF), Color(0xFF2563EB)],
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.spa_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'LUMI',
                      style: GoogleFonts.outfit(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        _MenuButton(
                          label: 'Features',
                          items: const [
                            _MenuItemData(title: 'Habit Tracker'),
                            _MenuItemData(title: 'AI Coach'),
                            _MenuItemData(title: 'Analytics'),
                            _MenuItemData(title: 'Journaling'),
                          ],
                        ),
                        const SizedBox(width: 24),
                        _MenuButton(
                          label: 'Solutions',
                          items: const [
                            _MenuItemData(title: 'Quit Alcohol'),
                            _MenuItemData(title: 'Quit Smoking'),
                            _MenuItemData(title: 'Gaming Addiction'),
                            _MenuItemData(title: 'Digital Detox'),
                          ],
                        ),
                        const SizedBox(width: 24),
                        _MenuButton(
                          label: 'Resources',
                          items: const [
                            _MenuItemData(title: 'Methodology'),
                            _MenuItemData(title: 'Success Stories'),
                            _MenuItemData(title: 'Blog'),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () => context.push('/auth'),
                          child: Text(
                            'Log In',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF111111),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        _GradientButton(
                          onPressed: () => context.push('/auth'),
                          child: const Text(
                            'Get LUMI Free',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _MenuItemData {
  final String title;
  const _MenuItemData({required this.title});
}

class _MenuButton extends StatefulWidget {
  final String label;
  final List<_MenuItemData> items;
  const _MenuButton({required this.label, required this.items});

  @override
  State<_MenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<_MenuButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: PopupMenuButton<int>(
        tooltip: widget.label,
        offset: const Offset(0, 50),
        color: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 8,
        shadowColor: Colors.black12,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        constraints: const BoxConstraints(minWidth: 200),
        padding: EdgeInsets.zero,
        itemBuilder: (BuildContext ctx) {
          return List<PopupMenuEntry<int>>.generate(widget.items.length, (i) {
            final item = widget.items[i];
            final isLast = i == widget.items.length - 1;
            return PopupMenuItem<int>(
              value: i,
              height: 40,
              padding: EdgeInsets.zero,
              child: _HoverableMenuItem(title: item.title, isLast: isLast),
            );
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: _isHovered ? Colors.grey.shade100 : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            children: [
              Text(
                widget.label,
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: _isHovered
                      ? const Color(0xFF6C63FF)
                      : const Color(0xFF111111),
                ),
              ),
              const SizedBox(width: 6),
              Icon(
                Icons.keyboard_arrow_down,
                size: 16,
                color: Colors.grey.shade400,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Clean, minimal menu item with smart hover effect (Notion/Linear style)
class _HoverableMenuItem extends StatefulWidget {
  final String title;
  final bool isLast;

  const _HoverableMenuItem({required this.title, required this.isLast});

  @override
  State<_HoverableMenuItem> createState() => _HoverableMenuItemState();
}

class _HoverableMenuItemState extends State<_HoverableMenuItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: _isHovered
              ? const Color(0xFF6C63FF).withValues(alpha: 0.08)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.title,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: _isHovered
                  ? const Color(0xFF6C63FF)
                  : const Color(0xFF111111),
            ),
          ),
        ),
      ),
    );
  }
}

class _LandingDrawer extends StatelessWidget {
  const _LandingDrawer();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.spa_rounded, color: AppColors.primary),
                  const SizedBox(width: 8),
                  Text(
                    'LUMI',
                    style: GoogleFonts.outfit(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const Divider(),
            ListTile(
              title: const Text('Log In'),
              onTap: () => context.push('/auth'),
            ),
          ],
        ),
      ),
    );
  }
}

/// HOW IT WORKS SECTION - 3 step cards
class _HowItWorksSection extends StatelessWidget {
  const _HowItWorksSection();

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 32,
        vertical: 60,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            children: [
              // Section Title
              Text(
                'Simple steps, big results',
                style: GoogleFonts.outfit(
                  fontSize: isMobile ? 28 : 42,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Follow our proven process to build better habits',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: const Color(0xFF666666),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 60),

              // Cards Layout
              if (isMobile)
                Column(
                  children: const [
                    _HowItWorksCard(
                      number: '01',
                      icon: Icons.check_circle_rounded,
                      title: 'Track Your Habits',
                      description:
                          'Log your daily actions and track progress effortlessly',
                    ),
                    SizedBox(height: 32),
                    _HowItWorksCard(
                      number: '02',
                      icon: Icons.trending_up_rounded,
                      title: 'Analyze Patterns',
                      description:
                          'Discover insights from AI-powered analytics',
                    ),
                    SizedBox(height: 32),
                    _HowItWorksCard(
                      number: '03',
                      icon: Icons.rocket_launch_rounded,
                      title: 'Achieve Success',
                      description:
                          'Reach your goals with personalized guidance',
                    ),
                  ],
                )
              else
                Row(
                  children: const [
                    Expanded(
                      child: _HowItWorksCard(
                        number: '01',
                        icon: Icons.check_circle_rounded,
                        title: 'Track Your Habits',
                        description:
                            'Log your daily actions and track progress effortlessly',
                      ),
                    ),
                    SizedBox(width: 32),
                    Expanded(
                      child: _HowItWorksCard(
                        number: '02',
                        icon: Icons.trending_up_rounded,
                        title: 'Analyze Patterns',
                        description:
                            'Discover insights from AI-powered analytics',
                      ),
                    ),
                    SizedBox(width: 32),
                    Expanded(
                      child: _HowItWorksCard(
                        number: '03',
                        icon: Icons.rocket_launch_rounded,
                        title: 'Achieve Success',
                        description:
                            'Reach your goals with personalized guidance',
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
}

/// Individual "How It Works" Card
class _HowItWorksCard extends StatelessWidget {
  final String number;
  final IconData icon;
  final String title;
  final String description;

  const _HowItWorksCard({
    required this.number,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(32),
      child: Stack(
        children: [
          // Background number
          Positioned(
            right: 16,
            top: 16,
            child: Text(
              number,
              style: GoogleFonts.outfit(
                fontSize: 100,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF6C63FF).withValues(alpha: 0.05),
              ),
            ),
          ),

          // Content
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gradient icon
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6C63FF), Color(0xFF2563EB)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(height: 20),

              // Title
              Text(
                title,
                style: GoogleFonts.outfit(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 12),

              // Description
              Text(
                description,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: const Color(0xFF666666),
                  height: 1.6,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// TRUST & REVIEWS SECTION
class _TrustSection extends StatelessWidget {
  const _TrustSection();

  static const List<Map<String, String>> reviews = [
    {
      'name': 'Maksat T.',
      'text':
          'Finally broke my smoking habit after 5 years! This app changed my life.',
      'initials': 'MT',
      'color': '0xFFFFE0B2',
    },
    {
      'name': 'Bekzat E.',
      'text':
          'The visual tracking helped me identify patterns I never noticed before.',
      'initials': 'BE',
      'color': '0xFFC8E6C9',
    },
    {
      'name': 'Magzhan T.',
      'text':
          'Clean design, powerful features. Exactly what I needed to stay accountable.',
      'initials': 'MT',
      'color': '0xFFBBDEFB',
    },
    {
      'name': 'Arai A.',
      'text':
          '28-day streak and counting! The achievements keep me motivated every day.',
      'initials': 'AA',
      'color': '0xFFF8BBD0',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Container(
      color: const Color(0xFFF5F3FF),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 32,
        vertical: 100,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            children: [
              if (isMobile)
                // Mobile: Column layout
                Column(
                  children: [
                    // Left text part
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Backed by Science,\nLoved by Users.',
                          style: GoogleFonts.outfit(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            height: 1.3,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'LUMI uses Cognitive Behavioral Therapy (CBT) techniques to help you understand your triggers and break harmful patterns with science-backed methods.',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            color: const Color(0xFF666666),
                            height: 1.6,
                          ),
                        ),
                        const SizedBox(height: 24),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            'Read our Methodology →',
                            style: GoogleFonts.outfit(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF6C63FF),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 60),
                    // Reviews grid
                    Column(
                      children: [
                        for (int i = 0; i < reviews.length; i += 2)
                          Column(
                            children: [
                              _ReviewCard(review: reviews[i]),
                              const SizedBox(height: 24),
                              if (i + 1 < reviews.length)
                                _ReviewCard(review: reviews[i + 1]),
                              if (i + 1 < reviews.length)
                                const SizedBox(height: 24),
                            ],
                          ),
                      ],
                    ),
                  ],
                )
              else
                // Desktop: Row layout
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left text part (40%)
                    Expanded(
                      flex: 40,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Backed by Science,\nLoved by Users.',
                            style: GoogleFonts.outfit(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 32),
                          Text(
                            'LUMI uses Cognitive Behavioral Therapy (CBT) techniques to help you understand your triggers and break harmful patterns with science-backed methods.',
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              color: const Color(0xFF666666),
                              height: 1.7,
                            ),
                          ),
                          const SizedBox(height: 32),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              'Read our Methodology →',
                              style: GoogleFonts.outfit(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF6C63FF),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 80),
                    // Right reviews grid (60%)
                    Expanded(
                      flex: 60,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: _ReviewCard(review: reviews[0]),
                              ),
                              const SizedBox(width: 24),
                              Expanded(
                                child: _ReviewCard(review: reviews[1]),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              Expanded(
                                child: _ReviewCard(review: reviews[2]),
                              ),
                              const SizedBox(width: 24),
                              Expanded(
                                child: _ReviewCard(review: reviews[3]),
                              ),
                            ],
                          ),
                        ],
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
}

/// Individual Review Card
class _ReviewCard extends StatelessWidget {
  final Map<String, String> review;

  const _ReviewCard({required this.review});

  @override
  Widget build(BuildContext context) {
    final colorString = review['color'] ?? '0xFFBBDEFB';
    final backgroundColor = Color(int.parse(colorString));

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 5 Stars
          Row(
            children: List.generate(
              5,
              (index) => Padding(
                padding: const EdgeInsets.only(right: 4),
                child: const Icon(
                  Icons.star_rounded,
                  color: Color(0xFFFFC107),
                  size: 18,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Review text
          Text(
            review['text'] ?? '',
            style: GoogleFonts.inter(
              fontSize: 14,
              color: const Color(0xFF555555),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),

          // Avatar + Name
          Row(
            children: [
              CircleAvatar(
                backgroundColor: backgroundColor,
                radius: 20,
                child: Text(
                  review['initials'] ?? '',
                  style: GoogleFonts.outfit(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                review['name'] ?? '',
                style: GoogleFonts.outfit(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// CTA BANNER SECTION
class _CTABanner extends StatelessWidget {
  const _CTABanner();

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 32),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6C63FF), Color(0xFF2563EB)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 64,
        vertical: isMobile ? 48 : 64,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
              // Main heading
              Text(
                'Ready to Start Your Journey?',
                style: GoogleFonts.outfit(
                  fontSize: isMobile ? 28 : 42,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              // Subheading
              Text(
                'Join thousands who are taking control of their habits and transforming their lives today.',
                style: GoogleFonts.inter(
                  fontSize: isMobile ? 14 : 16,
                  color: Colors.white.withValues(alpha: 0.9),
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),

              // CTA Button - White with Purple text
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 32 : 48,
                  vertical: isMobile ? 12 : 16,
                ),
                child: GestureDetector(
                  onTap: () {
                    // Handle button press
                    context.push('/auth');
                  },
                  child: Text(
                    'Get Started Now',
                    style: GoogleFonts.outfit(
                      fontSize: isMobile ? 14 : 16,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF6C63FF),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GradientButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  const _GradientButton({required this.onPressed, required this.child});
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF6C63FF), Color(0xFF2563EB)],
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6C63FF).withValues(alpha: 0.3),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          child: child,
        ),
      ),
    );
  }
}

class _OutlineCTA extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  const _OutlineCTA({required this.onPressed, required this.child});
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        side: BorderSide(color: Colors.grey.shade300),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: child,
    );
  }
}

/// FOOTER LINK WIDGET
class _FooterLink extends StatelessWidget {
  final String text;

  const _FooterLink(this.text);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 13,
          color: Colors.white70,
        ),
      ),
    );
  }
}

/// SOCIAL ICON WIDGET
class _SocialIcon extends StatelessWidget {
  final IconData icon;

  const _SocialIcon(this.icon);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Icon(
        icon,
        color: Colors.white54,
        size: 18,
      ),
    );
  }
}
