import 'package:flutter/material.dart';

/// Утилита для определения типа устройства и получения адаптивных значений
class ResponsiveUtil {
  /// Определяет, является ли устройство desktopом (> 900px)
  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width > 900;
  }

  /// Определяет, является ли устройство tablet'ом (600 - 900px)
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width > 600 && width <= 900;
  }

  /// Определяет, является ли устройство мобильным (< 600px)
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width <= 600;
  }

  /// Получает ширину экрана
  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  /// Получает высоту экрана
  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  /// Адаптивная ширина padding
  /// Desktop: 40, Tablet: 32, Mobile: 24
  static double getPadding(BuildContext context) {
    final width = screenWidth(context);
    if (width > 900) return 40.0;
    if (width > 600) return 32.0;
    return 24.0;
  }

  /// Адаптивный размер шрифта для заголовков (H1)
  /// Desktop: 48, Tablet: 40, Mobile: 32
  static double getHeadline1FontSize(BuildContext context) {
    final width = screenWidth(context);
    if (width > 900) return 48.0;
    if (width > 600) return 40.0;
    return 32.0;
  }

  /// Адаптивный размер шрифта для подзаголовков (H2)
  /// Desktop: 36, Tablet: 32, Mobile: 28
  static double getHeadline2FontSize(BuildContext context) {
    final width = screenWidth(context);
    if (width > 900) return 36.0;
    if (width > 600) return 32.0;
    return 28.0;
  }

  /// Адаптивный размер шрифта для H3
  /// Desktop: 28, Tablet: 24, Mobile: 20
  static double getHeadline3FontSize(BuildContext context) {
    final width = screenWidth(context);
    if (width > 900) return 28.0;
    if (width > 600) return 24.0;
    return 20.0;
  }

  /// Адаптивный размер шрифта для подписей (Caption)
  /// Desktop: 24, Tablet: 20, Mobile: 18
  static double getCaptionFontSize(BuildContext context) {
    final width = screenWidth(context);
    if (width > 900) return 24.0;
    if (width > 600) return 20.0;
    return 18.0;
  }

  /// Адаптивный размер шрифта для body текста
  /// Desktop: 16, Tablet: 15, Mobile: 14
  static double getBodyFontSize(BuildContext context) {
    final width = screenWidth(context);
    if (width > 900) return 16.0;
    if (width > 600) return 15.0;
    return 14.0;
  }

  /// Адаптивный размер шрифта для small текста
  /// Desktop: 14, Tablet: 13, Mobile: 12
  static double getSmallFontSize(BuildContext context) {
    final width = screenWidth(context);
    if (width > 900) return 14.0;
    if (width > 600) return 13.0;
    return 12.0;
  }

  /// Адаптивный размер иконки
  /// Desktop: 32, Tablet: 28, Mobile: 24
  static double getIconSize(BuildContext context) {
    final width = screenWidth(context);
    if (width > 900) return 32.0;
    if (width > 600) return 28.0;
    return 24.0;
  }

  /// Адаптивный размер большой иконки
  /// Desktop: 48, Tablet: 40, Mobile: 32
  static double getLargeIconSize(BuildContext context) {
    final width = screenWidth(context);
    if (width > 900) return 48.0;
    if (width > 600) return 40.0;
    return 32.0;
  }

  /// Адаптивный vertical padding
  /// Desktop: 32, Tablet: 24, Mobile: 16
  static double getVerticalPadding(BuildContext context) {
    final width = screenWidth(context);
    if (width > 900) return 32.0;
    if (width > 600) return 24.0;
    return 16.0;
  }

  /// Адаптивный horizontal padding
  /// Desktop: 40, Tablet: 32, Mobile: 24
  static double getHorizontalPadding(BuildContext context) {
    final width = screenWidth(context);
    if (width > 900) return 40.0;
    if (width > 600) return 32.0;
    return 24.0;
  }

  /// Адаптивный card padding
  /// Desktop: 32, Tablet: 24, Mobile: 20
  static double getCardPadding(BuildContext context) {
    final width = screenWidth(context);
    if (width > 900) return 32.0;
    if (width > 600) return 24.0;
    return 20.0;
  }

  /// Адаптивный spacing между элементами
  /// Desktop: 32, Tablet: 24, Mobile: 16
  static double getElementSpacing(BuildContext context) {
    final width = screenWidth(context);
    if (width > 900) return 32.0;
    if (width > 600) return 24.0;
    return 16.0;
  }
}
