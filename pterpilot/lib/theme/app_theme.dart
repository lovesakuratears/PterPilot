import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData light() {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.light,
        primary: AppColors.primary,
        onPrimary: AppColors.onPrimary,
        secondary: const Color(0xFF4A6360),
        tertiary: AppColors.magic,
        surface: const Color(0xFFFBFCFC),
        onSurface: AppColors.onSurface,
        surfaceContainerHighest: const Color(0xFFDEE3E2),
        onSurfaceVariant: AppColors.onSurfaceVariant,
        outline: const Color(0xFF6F7978),
        outlineVariant: const Color(0xFFBEC8C7),
      ),
      scaffoldBackgroundColor: const Color(0xFFF4F8F7),
    );

    return base.copyWith(
      textTheme: _buildTextTheme(Brightness.light),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: Colors.white.withValues(alpha: 0.72),
        surfaceTintColor: Colors.transparent,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: AppColors.onSurface,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white.withValues(alpha: 0.45),
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.onSurfaceDim,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedLabelStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
        unselectedLabelStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: Colors.white.withValues(alpha: 0.45),
        selectedColor: AppColors.primary.withValues(alpha: 0.15),
        labelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        side: BorderSide(color: Colors.white.withValues(alpha: 0.5)),
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 7),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          minimumSize: const Size.fromHeight(48),
          shape: const StadiumBorder(),
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.45),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(999),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.5)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(999),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(999),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  static ThemeData dark() {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColorsDark.primary,
        brightness: Brightness.dark,
        primary: AppColorsDark.primary,
        onPrimary: AppColorsDark.onPrimary,
        secondary: const Color(0xFFB4CCC8),
        tertiary: AppColorsDark.magic,
        surface: const Color(0xFF0E1514),
        onSurface: AppColorsDark.onSurface,
        surfaceContainerHighest: const Color(0xFF2E3837),
        onSurfaceVariant: AppColorsDark.onSurfaceVariant,
        outline: const Color(0xFF899291),
        outlineVariant: const Color(0xFF3A4544),
      ),
      scaffoldBackgroundColor: const Color(0xFF0A0F0E),
    );

    return base.copyWith(
      textTheme: _buildTextTheme(Brightness.dark),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: const Color(0xFF141E1C).withValues(alpha: 0.72),
        surfaceTintColor: Colors.transparent,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: AppColorsDark.onSurface,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: const Color(0xFF141E1C).withValues(alpha: 0.45),
        selectedItemColor: AppColorsDark.primary,
        unselectedItemColor: AppColorsDark.onSurfaceDim,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedLabelStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
        unselectedLabelStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: const Color(0xFF141E1C).withValues(alpha: 0.45),
        selectedColor: AppColorsDark.primary.withValues(alpha: 0.15),
        labelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        side: BorderSide(color: Colors.white.withValues(alpha: 0.12)),
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 7),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColorsDark.primary,
          foregroundColor: AppColorsDark.onPrimary,
          minimumSize: const Size.fromHeight(48),
          shape: const StadiumBorder(),
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF141E1C).withValues(alpha: 0.45),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(999),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.12)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(999),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.12)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(999),
          borderSide: const BorderSide(color: AppColorsDark.primary),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  static TextTheme _buildTextTheme(Brightness brightness) {
    final color = brightness == Brightness.light
        ? AppColors.onSurface
        : AppColorsDark.onSurface;
    final variant = brightness == Brightness.light
        ? AppColors.onSurfaceVariant
        : AppColorsDark.onSurfaceVariant;
    final dim = brightness == Brightness.light
        ? AppColors.onSurfaceDim
        : AppColorsDark.onSurfaceDim;

    return TextTheme(
      displayLarge: TextStyle(fontSize: 34, fontWeight: FontWeight.w700, color: color, height: 1.2),
      displayMedium: TextStyle(fontSize: 30, fontWeight: FontWeight.w700, color: color, height: 1.2),
      titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: color, height: 1.3),
      titleMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: color, height: 1.35),
      titleSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: color, height: 1.4),
      bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: color, height: 1.5),
      bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: color, height: 1.5),
      bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: variant, height: 1.4),
      labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: color, height: 1.4),
      labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: variant, height: 1.3),
      labelSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.w400, color: dim, height: 1.2),
    );
  }
}
