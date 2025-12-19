      body: Stack(
        children: [
          // Full-page scrollable content (fills Stack)
          Positioned.fill(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header
                  Material(
                    elevation: 2,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
                      child: LayoutBuilder(builder: (context, constraints) {
                        final isDesktop = constraints.maxWidth > 900;
                        return Row(
                          children: [
                            Row(children: [
                              Icon(Icons.spa_rounded, color: AppColors.primary),
                              const SizedBox(width: 8),
                              Text('LUMI', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold))
                            ]),
                            if (isDesktop) ...[
                              const Spacer(),
                              Row(children: [
                                TextButton(onPressed: () {}, child: const Text('Features')),
                                TextButton(onPressed: () {}, child: const Text('How it Works')),
                                TextButton(onPressed: () {}, child: const Text('Community')),
                              ]),
                              const Spacer(),
                            ] else ...[
                              const Spacer(),
                            ],
                            Row(children: [
                              TextButton(onPressed: () => context.push('/auth'), child: const Text('Log In')),
                              const SizedBox(width: 8),
                              ElevatedButton(onPressed: () => context.push('/auth'), style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary), child: const Text('Get LUMI Free'))
                            ])
                          ],
                        );
                      }),
                    ),
                  ),

                  // Hero
                  Container(
                    height: height,
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    width: double.infinity,
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1200),
                        child: LayoutBuilder(builder: (context, constraints) {
                          final isWide = constraints.maxWidth > 900;
                          return Row(
                            children: [
                              Expanded(
                                flex: 6,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Quit Bad Habits. Start Living.', style: theme.textTheme.headlineLarge?.copyWith(fontSize: isWide ? 64 : 32, fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 16),
                                    Text('AI-powered tracker for alcohol, smoking, and gaming addiction.', style: theme.textTheme.titleMedium?.copyWith(color: Colors.grey.shade700)),
                                    const SizedBox(height: 24),
                                    Row(children: [
                                      ElevatedButton(onPressed: () => context.push('/auth'), style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16)), child: const Text('Start Tracking Now')),
                                      const SizedBox(width: 12),
                                      OutlinedButton(onPressed: () => context.push('/auth'), child: const Text('Watch Demo'))
                                    ])
                                  ],
                                ),
                              ),
                              if (isWide) const Spacer(),
                              Expanded(flex: 4, child: Center(child: Icon(Icons.monitor_heart, size: isWide ? 240 : 160, color: AppColors.primary.withAlpha(180))))
                            ],
                          );
                        }),
                      ),
                    ),
                  ),

                  // Features
                  Container(
                    color: Colors.grey[50],
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 56, horizontal: 24),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1100),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text('Everything you need to succeed', style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 20),
                          Wrap(spacing: 16, runSpacing: 16, children: const [
                            _FeatureTile(icon: Icons.smart_toy, title: 'AI Coach', subtitle: 'Personalized chat-based guidance'),
                            _FeatureTile(icon: Icons.bar_chart, title: 'Analytics', subtitle: 'Visualize your progress with insights'),
                            _FeatureTile(icon: Icons.lock_outline, title: 'Privacy First', subtitle: 'All data stays on your device'),
                          ])
                        ]),
                      ),
                    ),
                  ),

                  // Footer
                  Container(
                    color: const Color(0xFF2D2D2D),
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1100),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(children: [Icon(Icons.spa_rounded, color: Colors.white), const SizedBox(width: 8), Text('LUMI', style: theme.textTheme.titleMedium?.copyWith(color: Colors.white))]), const SizedBox(height: 12), Text('Quit bad habits and build a better life.', style: theme.textTheme.bodySmall?.copyWith(color: Colors.white70))])),
                            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Product', style: theme.textTheme.titleSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)), const SizedBox(height: 8), TextButton(onPressed: () {}, child: const Text('Features', style: TextStyle(color: Colors.white70))), TextButton(onPressed: () {}, child: const Text('Pricing', style: TextStyle(color: Colors.white70)))])),
                            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Legal', style: theme.textTheme.titleSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)), const SizedBox(height: 8), TextButton(onPressed: () {}, child: const Text('Terms', style: TextStyle(color: Colors.white70))), TextButton(onPressed: () {}, child: const Text('Privacy', style: TextStyle(color: Colors.white70)))])),
                          ]),
                          const SizedBox(height: 24),
                          Text('Copyright © 2025 LUMI', style: theme.textTheme.bodySmall?.copyWith(color: Colors.white70))
                        ]),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Floating assistant
            const Positioned(bottom: 20, right: 20, child: FloatingAiChat()),
          ],
        ),
      );
    }
  }

  class _FeatureTile extends StatelessWidget {
    final IconData icon;
    final String title;
    final String subtitle;

    const _FeatureTile({required this.icon, required this.title, required this.subtitle});

    @override
    Widget build(BuildContext context) {
      final theme = Theme.of(context);
      return SizedBox(
        width: 340,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(color: const Color(0x14000000), blurRadius: 8, offset: const Offset(0, 6))]),
          child: Row(children: [
            CircleAvatar(radius: 26, backgroundColor: AppColors.primary.withAlpha(30), child: Icon(icon, color: AppColors.primary)),
            const SizedBox(width: 16),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)), const SizedBox(height: 8), Text(subtitle, style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey.shade600))]))
          ]),
        ),
      );
    }
  }
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header
                  Material(
                    import 'package:flutter/material.dart';
                    import 'package:go_router/go_router.dart';

                    import '../../core/theme/app_theme.dart';
                    import 'widgets/floating_ai_chat.dart';

                    class LandingPage extends StatelessWidget {
                      const LandingPage({super.key});

                      @override
                      Widget build(BuildContext context) {
                        final theme = Theme.of(context);
                        final height = MediaQuery.of(context).size.height * 0.9;

                        return Scaffold(
                          drawer: Drawer(
                            child: SafeArea(
                              child: ListView(
                                padding: EdgeInsets.zero,
                                children: [
                                  const ListTile(title: Text('Features')),
                                  const ListTile(title: Text('How it Works')),
                                  const ListTile(title: Text('Community')),
                                  const ListTile(title: Text('FAQ')),
                                  const Divider(),
                                  ListTile(
                                    title: const Text('Log In'),
                                    onTap: () => context.push('/auth'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                                    child: ElevatedButton(
                                      onPressed: () => context.push('/auth'),
                                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
                                      child: const Text('Get LUMI Free'),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          body: Stack(
                            children: [
                              Positioned.fill(
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      // Header
                                      Material(
                                        elevation: 2,
                                        color: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
                                          child: LayoutBuilder(builder: (context, constraints) {
                                            final isDesktop = constraints.maxWidth > 900;
                                            return Row(
                                              children: [
                                                Row(children: [
                                                  Icon(Icons.spa_rounded, color: AppColors.primary),
                                                  const SizedBox(width: 8),
                                                  Text('LUMI', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold))
                                                ]),
                                                if (isDesktop) ...[
                                                  const Spacer(),
                                                  Row(children: [
                                                    TextButton(onPressed: () {}, child: const Text('Features')),
                                                    TextButton(onPressed: () {}, child: const Text('How it Works')),
                                                    TextButton(onPressed: () {}, child: const Text('Community')),
                                                  ]),
                                                  const Spacer(),
                                                ] else ...[
                                                  const Spacer(),
                                                ],
                                                Row(children: [
                                                  TextButton(onPressed: () => context.push('/auth'), child: const Text('Log In')),
                                                  const SizedBox(width: 8),
                                                  ElevatedButton(onPressed: () => context.push('/auth'), style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary), child: const Text('Get LUMI Free'))
                                                ])
                                              ],
                                            );
                                          }),
                                        ),
                                      ),

                                      // Hero
                                      Container(
                                        height: height,
                                        padding: const EdgeInsets.symmetric(horizontal: 32),
                                        width: double.infinity,
                                        child: Center(
                                          child: ConstrainedBox(
                                            constraints: const BoxConstraints(maxWidth: 1200),
                                            child: LayoutBuilder(builder: (context, constraints) {
                                              final isWide = constraints.maxWidth > 900;
                                              return Row(
                                                children: [
                                                  Expanded(
                                                    flex: 6,
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text('Quit Bad Habits. Start Living.', style: theme.textTheme.headlineLarge?.copyWith(fontSize: isWide ? 64 : 32, fontWeight: FontWeight.bold)),
                                                        const SizedBox(height: 16),
                                                        Text('AI-powered tracker for alcohol, smoking, and gaming addiction.', style: theme.textTheme.titleMedium?.copyWith(color: Colors.grey.shade700)),
                                                        const SizedBox(height: 24),
                                                        Row(children: [
                                                          ElevatedButton(onPressed: () => context.push('/auth'), style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16)), child: const Text('Start Tracking Now')),
                                                          const SizedBox(width: 12),
                                                          OutlinedButton(onPressed: () => context.push('/auth'), child: const Text('Watch Demo'))
                                                        ])
                                                      ],
                                                    ),
                                                  ),
                                                  if (isWide) const Spacer(),
                                                  Expanded(flex: 4, child: Center(child: Icon(Icons.monitor_heart, size: isWide ? 240 : 160, color: AppColors.primary.withAlpha(180))))
                                                ],
                                              );
                                            }),
                                          ),
                                        ),
                                      ),

                                      // Features
                                      Container(
                                        color: Colors.grey[50],
                                        width: double.infinity,
                                        padding: const EdgeInsets.symmetric(vertical: 56, horizontal: 24),
                                        child: Center(
                                          child: ConstrainedBox(
                                            constraints: const BoxConstraints(maxWidth: 1100),
                                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                              Text('Everything you need to succeed', style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                                              const SizedBox(height: 20),
                                              Wrap(spacing: 16, runSpacing: 16, children: const [
                                                _FeatureTile(icon: Icons.smart_toy, title: 'AI Coach', subtitle: 'Personalized chat-based guidance'),
                                                _FeatureTile(icon: Icons.bar_chart, title: 'Analytics', subtitle: 'Visualize your progress with insights'),
                                                _FeatureTile(icon: Icons.lock_outline, title: 'Privacy First', subtitle: 'All data stays on your device'),
                                              ])
                                            ]),
                                          ),
                                        ),
                                      ),

                                      // Footer
                                      Container(
                                        color: const Color(0xFF2D2D2D),
                                        width: double.infinity,
                                        padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
                                        child: Center(
                                          child: ConstrainedBox(
                                            constraints: const BoxConstraints(maxWidth: 1100),
                                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(children: [Icon(Icons.spa_rounded, color: Colors.white), const SizedBox(width: 8), Text('LUMI', style: theme.textTheme.titleMedium?.copyWith(color: Colors.white))]), const SizedBox(height: 12), Text('Quit bad habits and build a better life.', style: theme.textTheme.bodySmall?.copyWith(color: Colors.white70))])),
                                                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Product', style: theme.textTheme.titleSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)), const SizedBox(height: 8), TextButton(onPressed: () {}, child: const Text('Features', style: TextStyle(color: Colors.white70))), TextButton(onPressed: () {}, child: const Text('Pricing', style: TextStyle(color: Colors.white70)))])),
                                                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Legal', style: theme.textTheme.titleSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)), const SizedBox(height: 8), TextButton(onPressed: () {}, child: const Text('Terms', style: TextStyle(color: Colors.white70))), TextButton(onPressed: () {}, child: const Text('Privacy', style: TextStyle(color: Colors.white70)))])),
                                              ]),
                                              const SizedBox(height: 24),
                                              Text('Copyright © 2025 LUMI', style: theme.textTheme.bodySmall?.copyWith(color: Colors.white70))
                                            ]),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              // Floating assistant
                              const Positioned(bottom: 20, right: 20, child: FloatingAiChat()),
                            ],
                          ),
                        );
                      }
                    }

                    class _FeatureTile extends StatelessWidget {
                      final IconData icon;
                      final String title;
                      final String subtitle;

                      const _FeatureTile({required this.icon, required this.title, required this.subtitle});

                      @override
                      Widget build(BuildContext context) {
                        final theme = Theme.of(context);
                        return SizedBox(
                          width: 340,
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: AppColors.surface,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [BoxShadow(color: const Color(0x14000000), blurRadius: 8, offset: const Offset(0, 6))]),
                            child: Row(children: [
                              CircleAvatar(radius: 26, backgroundColor: AppColors.primary.withAlpha(30), child: Icon(icon, color: AppColors.primary)),
                              const SizedBox(width: 16),
                              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)), const SizedBox(height: 8), Text(subtitle, style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey.shade600))]))
                            ]),
                          ),
                        );
                      }
                    }
