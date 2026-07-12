import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF00B4A0);
  static const Color primaryLight = Color(0xFF5FD8C7);
  static const Color primaryDark = Color(0xFF006A60);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onPrimaryContainer = Color(0xFF00201C);

  static const Color magic = Color(0xFF7C5CFC);
  static const Color success = Color(0xFF10B981);
  static const Color warn = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  static const Color onSurface = Color(0xFF1A2332);
  static const Color onSurfaceVariant = Color(0xFF4A5568);
  static const Color onSurfaceDim = Color(0xFF8896A7);

  static const Color glassBorder = Color(0x80FFFFFF);
  static const Color glassHighlight = Color(0xB3FFFFFF);

  static const Color tmdb = Color(0xFFF59E0B);
  static const Color douban = Color(0xFF10B981);
}

class AppColorsDark {
  static const Color primary = Color(0xFF5FD8C7);
  static const Color primaryLight = Color(0xFF8EEADF);
  static const Color primaryDark = Color(0xFF00B4A0);
  static const Color onPrimary = Color(0xFF003731);
  static const Color onPrimaryContainer = Color(0xFF9CF2E4);

  static const Color magic = Color(0xFFB69CFF);
  static const Color success = Color(0xFF6EE7B7);
  static const Color warn = Color(0xFFFCD34D);
  static const Color error = Color(0xFFFCA5A5);
  static const Color info = Color(0xFF93C5FD);

  static const Color onSurface = Color(0xFFE8EEF2);
  static const Color onSurfaceVariant = Color(0xFFA0B0BF);
  static const Color onSurfaceDim = Color(0xFF6B7D8E);

  static const Color glassBorder = Color(0x1FFFFFFF);
  static const Color glassHighlight = Color(0x14FFFFFF);
}

class AppGradients {
  static const LinearGradient bgLight = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFE8F5F2), Color(0xFFD4EDE8), Color(0xFFF0F7F6)],
  );

  static const LinearGradient bgDark = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF0A1418), Color(0xFF0E1A22), Color(0xFF0C161E)],
  );

  static const LinearGradient profileAvatar = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.primary, AppColors.magic],
  );

  static const LinearGradient heroBanner = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0x00000000), Color(0xCC000000)],
  );
}

class AppGlass {
  static const double blur = 20.0;
  static const double blurHeavy = 32.0;
  static const double saturate = 1.8;

  static List<BoxShadow> shadowSmall(bool isDark) => [
        BoxShadow(
          color: isDark
              ? Colors.black.withValues(alpha: 0.3)
              : Colors.black.withValues(alpha: 0.06),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
        BoxShadow(
          color: isDark
              ? Colors.white.withValues(alpha: 0.06)
              : Colors.white.withValues(alpha: 0.5),
          blurRadius: 0,
          offset: const Offset(0, 1),
          spreadRadius: 0,
        ),
      ];

  static List<BoxShadow> shadowMedium(bool isDark) => [
        BoxShadow(
          color: isDark
              ? Colors.black.withValues(alpha: 0.35)
              : Colors.black.withValues(alpha: 0.08),
          blurRadius: 16,
          offset: const Offset(0, 4),
        ),
        BoxShadow(
          color: isDark
              ? Colors.white.withValues(alpha: 0.08)
              : Colors.white.withValues(alpha: 0.6),
          blurRadius: 0,
          offset: const Offset(0, 1),
          spreadRadius: 0,
        ),
      ];

  static List<BoxShadow> shadowLarge(bool isDark) => [
        BoxShadow(
          color: isDark
              ? Colors.black.withValues(alpha: 0.4)
              : Colors.black.withValues(alpha: 0.10),
          blurRadius: 32,
          offset: const Offset(0, 8),
        ),
        BoxShadow(
          color: isDark
              ? Colors.white.withValues(alpha: 0.10)
              : Colors.white.withValues(alpha: 0.7),
          blurRadius: 0,
          offset: const Offset(0, 1),
          spreadRadius: 0,
        ),
      ];
}
