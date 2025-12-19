import 'package:flutter/material.dart';
// model only, no theme required

/// Simple model describing one onboarding slide
class OnboardingSlide {
  final String title;
  final String subtitle;
  final IconData icon;

  const OnboardingSlide({
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}

/// The three onboarding slides used by the UI
const List<OnboardingSlide> onboardingSlides = [
  OnboardingSlide(
    title: 'Welcome to LUMI',
    subtitle:
        'Your personal companion for breaking bad habits and building a better you.',
    icon: Icons.waving_hand_rounded,
  ),
  OnboardingSlide(
    title: 'Track Progress',
    subtitle:
        'Monitor your days without alcohol, smoking, or gaming. Visualize your success.',
    icon: Icons.insights_rounded,
  ),
  OnboardingSlide(
    title: 'AI Coaching',
    subtitle:
        'Get personalized tips and motivation from our smart AI assistant.',
    icon: Icons.psychology_rounded,
  ),
];
