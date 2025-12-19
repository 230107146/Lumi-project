import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_theme.dart';
import '../../core/utils/responsive.dart';
import '../../core/widgets/responsive_wrapper.dart';
import 'onboarding_model.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _current = 0;

  void _onNext() {
    if (_current < onboardingSlides.length - 1) {
      _controller.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      // final slide: go to /auth
      context.go('/auth');
    }
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      final page = (_controller.page ?? 0).round();
      if (page != _current) setState(() => _current = page);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(onboardingSlides.length, (index) {
        final active = index == _current;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.symmetric(horizontal: 6),
          width: active ? 18 : 10,
          height: 10,
          decoration: BoxDecoration(
            color: active ? AppColors.primary : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(20),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDesktop = ResponsiveUtil.isDesktop(context);
    final padding = ResponsiveUtil.getPadding(context);
    final iconSize = ResponsiveUtil.getLargeIconSize(context);
    final titleSize = ResponsiveUtil.getHeadline3FontSize(context);
    final subtitleSize = ResponsiveUtil.getBodyFontSize(context);
    final buttonHeight = isDesktop ? 56.0 : 50.0;

    return ResponsiveWrapper(
      child: Scaffold(
        backgroundColor: theme.colorScheme.surface,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: padding * 0.6),
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _controller,
                    itemCount: onboardingSlides.length,
                    itemBuilder: (context, index) {
                      final slide = onboardingSlides[index];
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: iconSize / 2,
                            backgroundColor: AppColors.primary.withAlpha(31),
                            child: Icon(
                              slide.icon,
                              size: iconSize,
                              color: AppColors.primary,
                            ),
                          ),
                          SizedBox(height: isDesktop ? 40 : 28),
                          Text(
                            slide.title,
                            style: theme.textTheme.headlineSmall?.copyWith(
                                fontSize: titleSize,
                                fontWeight: FontWeight.w700),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: isDesktop ? 16 : 12),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: padding),
                            child: Text(
                              slide.subtitle,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                  fontSize: subtitleSize,
                                  color: Colors.grey.shade600),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(height: isDesktop ? 24 : 16),
                _buildDots(),
                SizedBox(height: isDesktop ? 32 : 20),
                SizedBox(
                  width: double.infinity,
                  height: buttonHeight,
                  child: ElevatedButton(
                    onPressed: _onNext,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                    ),
                    child: Text(
                      _current < onboardingSlides.length - 1
                          ? 'Next'
                          : 'Get Started',
                      style: theme.textTheme.labelLarge?.copyWith(
                          fontSize: subtitleSize,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                SizedBox(height: isDesktop ? 40 : 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
