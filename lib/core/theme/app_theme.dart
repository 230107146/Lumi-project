import 'package:flutter/material.dart';
// Avoid runtime font downloads (google_fonts) to keep app offline-friendly.

/// Color tokens used across the app
class AppColors {
  static const Color primary = Color(0xFF6C63FF); // #6C63FF
  static const Color background = Color(0xFFF7F7F7); // #F7F7F7
  static const Color surface = Color(0xFFFFFFFF); // #FFFFFF
}

/// Centralized Theme configuration for LUMI
class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    final base = ThemeData.light();

    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      surface: AppColors.surface,
      brightness: Brightness.light,
    );

    // Use base text theme to avoid network font loading issues on desktop.
    final textTheme = base.textTheme
        .apply(bodyColor: Colors.black87, displayColor: Colors.black87);

    return base.copyWith(
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.background,
      primaryColor: AppColors.primary,
      textTheme: textTheme,
      // AppBar theme
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.surface,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w600,
        ),
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      // Elevated/button styles
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 6,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      dialogTheme: DialogThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      // Global visual density and shapes
      visualDensity: VisualDensity.adaptivePlatformDensity,
      // Provide a default Elevated/Surface shape for Soft UI
      // Use a const color for shadow to avoid using deprecated withOpacity
      shadowColor: const Color(0x1F000000),
    );
  }
}
