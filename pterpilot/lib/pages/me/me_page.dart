import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/app_colors.dart';
import '../../widgets/glass_widgets.dart';
import '../../providers/app_providers.dart';
import '../plugins/plugins_page.dart';

class MePage extends ConsumerWidget {
  const MePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final totalMagic = ref.watch(totalMagicProvider);
    final totalUpload = ref.watch(totalUploadProvider);
    final signInRate = ref.watch(signInRateProvider);

    return GradientOrbsBackground(
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const IOSStatusBar(),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text(
                    '我的',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: isDark ? AppColorsDark.onSurface : AppColors.onSurface,
                    ),
                  ),
                  const Spacer(),
                  _CircularIconButton(
                    icon: Icons.settings_outlined,
                    isDark: isDark,
                    onTap: () {},
                  ),
                  const SizedBox(width: 10),
                  _CircularIconButton(
                    icon: Icons.notifications_outlined,
                    isDark: isDark,
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
                child: Column(
                  children: [
                    _ProfileHeroCard(
                      isDark: isDark,
                      totalMagic: totalMagic,
                      totalUpload: totalUpload,
                      signInRate: signInRate,
                    ),
                    const SizedBox(height: 16),
                    _FeatureGrid(isDark: isDark, onPluginsTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const PluginsPage()),
                      );
                    }),
                    const SizedBox(height: 16),
                    _QuickActionsCard(isDark: isDark),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CircularIconButton extends StatelessWidget {
  final IconData icon;
  final bool isDark;
  final VoidCallback onTap;

  const _CircularIconButton({
    required this.icon,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isDark
            ? Colors.white.withValues(alpha: 0.10)
            : Colors.white.withValues(alpha: 0.55),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.12)
              : Colors.white.withValues(alpha: 0.5),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          child: Icon(
            icon,
            size: 20,
            color: isDark ? AppColorsDark.onSurfaceVariant : AppColors.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}

class _ProfileHeroCard extends StatelessWidget {
  final bool isDark;
  final String totalMagic;
  final String totalUpload;
  final double signInRate;

  const _ProfileHeroCard({
    required this.isDark,
    required this.totalMagic,
    required this.totalUpload,
    required this.signInRate,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = isDark ? AppColorsDark.primary : AppColors.primary;
    final magicColor = isDark ? AppColorsDark.magic : AppColors.magic;

    return GlassCard(
      padding: 18,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppGradients.profileAvatar,
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withValues(alpha: 0.3),
                      blurRadius: 12,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Icon(
                  Icons.person_rounded,
                  size: 32,
                  color: isDark ? AppColorsDark.onPrimary : AppColors.onPrimary,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'PterPilot 用户',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: isDark ? AppColorsDark.onSurface : AppColors.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'PT 等级：白金会员 · 注册 365 天',
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark ? AppColorsDark.onSurfaceDim : AppColors.onSurfaceDim,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  isDark ? Colors.white.withValues(alpha: 0.12) : Colors.white.withValues(alpha: 0.5),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: _StatItem(
                  value: totalMagic,
                  label: '魔力值',
                  color: magicColor,
                  isDark: isDark,
                ),
              ),
              Container(
                width: 1,
                height: 36,
                color: isDark ? Colors.white.withValues(alpha: 0.1) : Colors.white.withValues(alpha: 0.4),
              ),
              Expanded(
                child: _StatItem(
                  value: totalUpload,
                  label: '上传量',
                  color: primaryColor,
                  isDark: isDark,
                ),
              ),
              Container(
                width: 1,
                height: 36,
                color: isDark ? Colors.white.withValues(alpha: 0.1) : Colors.white.withValues(alpha: 0.4),
              ),
              Expanded(
                child: _StatItem(
                  value: '${(signInRate * 100).toStringAsFixed(0)}%',
                  label: '签到率',
                  color: isDark ? AppColorsDark.success : AppColors.success,
                  isDark: isDark,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  final Color color;
  final bool isDark;

  const _StatItem({
    required this.value,
    required this.label,
    required this.color,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MonoText(
          value,
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: color,
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: isDark ? AppColorsDark.onSurfaceDim : AppColors.onSurfaceDim,
          ),
        ),
      ],
    );
  }
}

class _FeatureGrid extends StatelessWidget {
  final bool isDark;
  final VoidCallback onPluginsTap;

  const _FeatureGrid({
    required this.isDark,
    required this.onPluginsTap,
  });

  @override
  Widget build(BuildContext context) {
    final features = [
      (
        icon: Icons.extension_outlined,
        name: '插件市场',
        subtitle: '10个插件',
        color: isDark ? AppColorsDark.magic : AppColors.magic,
        onTap: onPluginsTap,
      ),
      (
        icon: Icons.shield_outlined,
        name: '隐私仪表盘',
        subtitle: '数据全本地加密',
        color: isDark ? AppColorsDark.primary : AppColors.primary,
        onTap: () {},
      ),
      (
        icon: Icons.feedback_outlined,
        name: '意见反馈',
        subtitle: 'G-5反馈闭环',
        color: isDark ? AppColorsDark.warn : AppColors.warn,
        onTap: () {},
      ),
      (
        icon: Icons.settings_outlined,
        name: '设置',
        subtitle: '主题/下载器/账户',
        color: isDark ? AppColorsDark.info : AppColors.info,
        onTap: () {},
      ),
    ];

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.25,
      children: features.map((f) {
        return _FeatureCard(
          icon: f.icon,
          name: f.name,
          subtitle: f.subtitle,
          color: f.color,
          isDark: isDark,
          onTap: f.onTap,
        );
      }).toList(),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String name;
  final String subtitle;
  final Color color;
  final bool isDark;
  final VoidCallback onTap;

  const _FeatureCard({
    required this.icon,
    required this.name,
    required this.subtitle,
    required this.color,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      onTap: onTap,
      padding: 14,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: color.withValues(alpha: 0.15),
            ),
            child: Icon(icon, size: 22, color: color),
          ),
          const Spacer(),
          Text(
            name,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isDark ? AppColorsDark.onSurface : AppColors.onSurface,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 11,
              color: isDark ? AppColorsDark.onSurfaceDim : AppColors.onSurfaceDim,
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickActionsCard extends StatelessWidget {
  final bool isDark;

  const _QuickActionsCard({required this.isDark});

  @override
  Widget build(BuildContext context) {
    final primaryColor = isDark ? AppColorsDark.primary : AppColors.primary;

    final actions = [
      (
        icon: Icons.cloud_sync_outlined,
        title: 'CookieCloud 同步',
        subtitle: '上次同步 2小时前',
        showArrow: true,
      ),
      (
        icon: Icons.help_outline,
        title: '新手引导',
        subtitle: '查看使用指南',
        showArrow: true,
      ),
      (
        icon: Icons.info_outline,
        title: '关于 PterPilot',
        subtitle: 'v0.1.0',
        showArrow: true,
      ),
    ];

    return GlassCard(
      padding: 0,
      child: Column(
        children: [
          for (var i = 0; i < actions.length; i++) ...[
            if (i > 0)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  height: 1,
                  color: isDark ? Colors.white.withValues(alpha: 0.08) : Colors.white.withValues(alpha: 0.4),
                ),
              ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  child: Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: primaryColor.withValues(alpha: 0.12),
                        ),
                        child: Icon(
                          actions[i].icon,
                          size: 20,
                          color: primaryColor,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              actions[i].title,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: isDark ? AppColorsDark.onSurface : AppColors.onSurface,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              actions[i].subtitle,
                              style: TextStyle(
                                fontSize: 12,
                                color: isDark ? AppColorsDark.onSurfaceDim : AppColors.onSurfaceDim,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (actions[i].showArrow)
                        Icon(
                          Icons.chevron_right,
                          size: 20,
                          color: isDark ? AppColorsDark.onSurfaceDim : AppColors.onSurfaceDim,
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
