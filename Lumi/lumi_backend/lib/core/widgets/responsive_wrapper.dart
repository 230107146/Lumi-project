import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// ResponsiveWrapper centers the app content for wide screens while keeping
/// a colored background on the sides. For widths > 600 it constrains the
/// content to 450px and shows a rounded, elevated surface in the center.
class ResponsiveWrapper extends StatelessWidget {
  final Widget child;

  const ResponsiveWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Desktop / wide screens
        if (constraints.maxWidth > 600) {
          return Container(
            color: AppColors.background,
            child: Center(
              child: ConstrainedBox(
                // Allow wider layout on desktop while still centering content
                constraints: const BoxConstraints(maxWidth: 1000),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Material(
                    color: AppColors.surface,
                    elevation: 8,
                    shadowColor: const Color(0x1F000000),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: child,
                    ),
                  ),
                ),
              ),
            ),
          );
        }

        // Mobile / narrow screens — stretch to full width, keep background
        return Container(color: AppColors.background, child: child);
      },
    );
  }
}
