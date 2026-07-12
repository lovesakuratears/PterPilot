import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final double padding;
  final double borderRadius;
  final VoidCallback? onTap;
  final bool darkMode;

  const GlassCard({
    super.key,
    required this.child,
    this.padding = 16,
    this.borderRadius = 16,
    this.onTap,
    this.darkMode = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = darkMode || Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: isDark
            ? const Color(0xFF141E1C).withValues(alpha: 0.55)
            : Colors.white.withValues(alpha: 0.55),
        border: Border.all(
          color: isDark ? Colors.white.withValues(alpha: 0.12) : Colors.white.withValues(alpha: 0.5),
          width: 1,
        ),
        boxShadow: AppGlass.shadowSmall(isDark),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(borderRadius),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Padding(
            padding: EdgeInsets.all(padding),
            child: child,
          ),
        ),
      ),
    );
  }
}

class StatusDot extends StatelessWidget {
  final Color color;
  final double size;
  final bool glow;

  const StatusDot({
    super.key,
    required this.color,
    this.size = 8,
    this.glow = true,
  });

  factory StatusDot.online({bool darkMode = false, double size = 8}) =>
      StatusDot(
        color: darkMode ? AppColorsDark.success : AppColors.success,
        size: size,
      );

  factory StatusDot.warning({bool darkMode = false, double size = 8}) =>
      StatusDot(
        color: darkMode ? AppColorsDark.warn : AppColors.warn,
        size: size,
      );

  factory StatusDot.offline({bool darkMode = false, double size = 8}) =>
      StatusDot(
        color: darkMode ? AppColorsDark.error : AppColors.error,
        size: size,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: glow
            ? [
                BoxShadow(
                  color: color.withValues(alpha: 0.6),
                  blurRadius: size,
                  spreadRadius: 0,
                ),
              ]
            : null,
      ),
    );
  }
}

class RatingBadge extends StatelessWidget {
  final double rating;
  final Color color;
  final String label;
  final bool showIcon;

  const RatingBadge({
    super.key,
    required this.rating,
    required this.color,
    required this.label,
    this.showIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showIcon) ...[
            Icon(Icons.star, size: 12, color: color),
            const SizedBox(width: 3),
          ],
          Text(
            '$label ${rating.toStringAsFixed(1)}',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class MonoText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color? color;

  const MonoText(
    this.text, {
    super.key,
    this.fontSize = 12,
    this.fontWeight = FontWeight.w500,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color ?? Theme.of(context).textTheme.bodyMedium?.color,
        fontFamily: 'monospace',
      ),
    );
  }
}

class GradientOrbsBackground extends StatelessWidget {
  final Widget child;

  const GradientOrbsBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -96,
          left: -96,
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
            child: Container(
              width: 288,
              height: 288,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0x3300B4A0),
              ),
            ),
          ),
        ),
        Positioned(
          top: 120,
          right: -64,
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
            child: Container(
              width: 224,
              height: 224,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0x267C5CFC),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 160,
          left: 80,
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 55, sigmaY: 55),
            child: Container(
              width: 256,
              height: 256,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0x1A3B82F6),
              ),
            ),
          ),
        ),
        child,
      ],
    );
  }
}

class IOSStatusBar extends StatelessWidget {
  final Color? textColor;

  const IOSStatusBar({super.key, this.textColor});

  @override
  Widget build(BuildContext context) {
    final color = textColor ?? Theme.of(context).textTheme.titleMedium?.color ?? Colors.black;
    return SizedBox(
      height: 44,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          children: [
            Text(
              '9:41',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Icon(Icons.signal_cellular_alt_2_bar, size: 14, color: color),
                const SizedBox(width: 4),
                Icon(Icons.wifi, size: 14, color: color),
                const SizedBox(width: 4),
                Icon(Icons.battery_full, size: 14, color: color),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
