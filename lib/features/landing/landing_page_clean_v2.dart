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
  // Заглушка, если AuthService не работает
  Future<void> _handleStartTracking() async {
    // Если AuthService дает ошибку, просто пиши: context.push('/auth');
    try {
      final loggedIn = await AuthService.isLoggedIn();
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
                color: const Color(0xFF6C63FF).withValues(alpha: 0.25)),
          ),
          Positioned(
            bottom: -100,
            right: -100,
            child: _AmbientBlob(
                color: const Color(0xFF2563EB).withValues(alpha: 0.2)),
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
                        child: LayoutBuilder(builder: (context, constraints) {
                          final isWide = constraints.maxWidth > 900;
                          return Row(
                            children: [
                              // Text Content
                              Expanded(
                                flex: 6,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF6C63FF)
                                            .withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            color: const Color(0xFF6C63FF)
                                                .withValues(alpha: 0.2)),
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
                                                color: const Color(0xFF111111))
                                            : GoogleFonts.outfit(
                                                fontSize: 42,
                                                fontWeight: FontWeight.w700,
                                                height: 1.1,
                                                color: const Color(0xFF111111)),
                                        children: [
                                          const TextSpan(
                                              text: 'Quit Bad Habits.\n'),
                                          WidgetSpan(
                                            child: _GradientText(
                                              'Start Living.',
                                              style: isWide
                                                  ? GoogleFonts.outfit(
                                                      fontSize: 64,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      height: 1.1)
                                                  : GoogleFonts.outfit(
                                                      fontSize: 42,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      height: 1.1),
                                              gradient: const LinearGradient(
                                                colors: [
                                                  Color(0xFF6C63FF),
                                                  Color(0xFF2563EB)
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
                                          color: const Color(0xFF555555)),
                                    ),
                                    const SizedBox(height: 32),
                                    Row(children: [
                                      _GradientButton(
                                        onPressed: _handleStartTracking,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: const [
                                            Text('Start Tracking Now',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w700)),
                                            SizedBox(width: 8),
                                            Icon(Icons.arrow_forward_rounded,
                                                color: Colors.white, size: 20),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      _OutlineCTA(
                                          onPressed: () =>
                                              context.push('/auth'),
                                          child: const Text('Watch Demo',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xFF111111))))
                                    ]),
                                    const SizedBox(height: 40),
                                    // Stats
                                    Row(
                                      children: const [
                                        _StatItem(
                                            value: '50K+',
                                            label: 'Active Users'),
                                        SizedBox(width: 24),
                                        _StatItem(
                                            value: '87%',
                                            label: 'Success Rate'),
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
                                    // ЛЕВИТИРУЮЩАЯ КАРТОЧКА ВМЕСТО ИКОНКИ
                                    child: _FloatingHeroCard(),
                                  ),
                                ),
                            ],
                          );
                        }),
                      ),
                    ),
                  ),

                  // FEATURES SECTION
                  Container(
                    color: Colors.white.withValues(alpha: 0.4),
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 80, horizontal: 24),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1100),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Powerful Features Built for Recovery',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.outfit(
                                      fontSize: 36,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF111111))),
                              const SizedBox(height: 16),
                              Text(
                                  'Everything you need to track, understand, and overcome addiction patterns.',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: const Color(0xFF666666))),
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
                                            'Get personalized recommendations based on your patterns'),
                                    _FeatureTile(
                                        emoji: '⚡',
                                        title: 'Real-Time Tracking',
                                        subtitle:
                                            'Log cravings and victories instantly with one tap'),
                                    _FeatureTile(
                                        emoji: '🤝',
                                        title: 'Community Support',
                                        subtitle:
                                            'Connect with thousands overcoming similar challenges'),
                                  ])
                            ]),
                      ),
                    ),
                  ),

                  // FOOTER
                  Container(
                    color: const Color(0xFF111111), // Modern Dark
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 60, horizontal: 24),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1100),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        gradient: const LinearGradient(colors: [
                                          Color(0xFF6C63FF),
                                          Color(0xFF2563EB)
                                        ]),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: const Icon(Icons.spa_rounded,
                                        color: Colors.white, size: 20),
                                  ),
                                  const SizedBox(width: 12),
                                  Text('LUMI',
                                      style: GoogleFonts.outfit(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white))
                                ]),
                                Text('© 2025 LUMI',
                                    style: GoogleFonts.inter(
                                        color: Colors.white54, fontSize: 14)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),

          // --- СЛОЙ 2: ПЛАВАЮЩИЙ ЧАТ ---
          Positioned(
            right: 20,
            bottom: 20,
            child: SafeArea(
              child: SizedBox(
                width: 360,
                child: const FloatingAiChat(),
              ),
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
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
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
        return Transform.translate(
          offset: Offset(0, offset),
          child: child,
        );
      },
      child: Container(
        width: 320,
        height: 400,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.7),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
              color: Colors.white.withValues(alpha: 0.8), width: 1.5),
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
                Text("Today's Progress",
                    style: GoogleFonts.outfit(
                        fontWeight: FontWeight.w600, fontSize: 16)),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [Color(0xFF6C63FF), Color(0xFF2563EB)]),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.bar_chart,
                      color: Colors.white, size: 16),
                )
              ],
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Streak", style: GoogleFonts.inter(color: Colors.grey)),
                Text("42 days",
                    style: GoogleFonts.outfit(
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF6C63FF),
                        fontSize: 18)),
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
                Text("Weekly Goal",
                    style: GoogleFonts.inter(color: Colors.grey)),
                Text("85%",
                    style: GoogleFonts.outfit(
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF2563EB),
                        fontSize: 18)),
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
            )
          ],
        ),
      ),
    );
  }
}

class _FeatureTile extends StatefulWidget {
  final String emoji;
  final String title;
  final String subtitle;

  const _FeatureTile(
      {required this.emoji, required this.title, required this.subtitle});

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
                    : Colors.white.withValues(alpha: 0.5)),
            boxShadow: [
              if (_hover)
                BoxShadow(
                    color: const Color(0xFF6C63FF).withValues(alpha: 0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10))
            ]),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(widget.emoji, style: const TextStyle(fontSize: 40)),
          const SizedBox(height: 16),
          Text(widget.title,
              style: GoogleFonts.outfit(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF111111))),
          const SizedBox(height: 8),
          Text(widget.subtitle,
              style: GoogleFonts.inter(
                  fontSize: 15, height: 1.5, color: const Color(0xFF666666)))
        ]),
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
        Text(value,
            style: GoogleFonts.outfit(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF6C63FF))),
        Text(label,
            style: GoogleFonts.inter(
                fontSize: 14, color: const Color(0xFF555555))),
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
                  color: Colors.white.withValues(alpha: 0.5), width: 1),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
            child: LayoutBuilder(builder: (context, constraints) {
              final isDesktop = constraints.maxWidth >= 900;
              if (!isDesktop) {
                return Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              colors: [Color(0xFF6C63FF), Color(0xFF2563EB)]),
                          borderRadius: BorderRadius.circular(8)),
                      child: const Icon(Icons.spa_rounded,
                          color: Colors.white, size: 20),
                    ),
                    const SizedBox(width: 8),
                    Text('LUMI',
                        style: GoogleFonts.outfit(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.menu),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                    )
                  ],
                );
              }

              return Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [Color(0xFF6C63FF), Color(0xFF2563EB)]),
                        borderRadius: BorderRadius.circular(8)),
                    child: const Icon(Icons.spa_rounded,
                        color: Colors.white, size: 20),
                  ),
                  const SizedBox(width: 10),
                  Text('LUMI',
                      style: GoogleFonts.outfit(
                          fontSize: 22, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  Row(children: [
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
                  ]),
                  const Spacer(),
                  Row(children: [
                    TextButton(
                        onPressed: () => context.push('/auth'),
                        child: Text('Log In',
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF111111)))),
                    const SizedBox(width: 12),
                    _GradientButton(
                      onPressed: () => context.push('/auth'),
                      child: const Text('Get LUMI Free',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600)),
                    ),
                  ]),
                ],
              );
            }),
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
              child: _HoverableMenuItem(
                title: item.title,
                isLast: isLast,
              ),
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
              Icon(Icons.keyboard_arrow_down,
                  size: 16, color: Colors.grey.shade400),
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
            child: ListView(padding: EdgeInsets.zero, children: [
      ListTile(
          title: Row(children: [
        Icon(Icons.spa_rounded, color: AppColors.primary),
        const SizedBox(width: 8),
        Text('LUMI', style: GoogleFonts.outfit(fontWeight: FontWeight.bold))
      ])),
      const Divider(),
      ListTile(title: const Text('Log In'), onTap: () => context.push('/auth')),
    ])));
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
                colors: [Color(0xFF6C63FF), Color(0xFF2563EB)]),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                  color: const Color(0xFF6C63FF).withValues(alpha: 0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 8))
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
