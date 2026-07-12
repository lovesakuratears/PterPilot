import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/app_colors.dart';
import '../../widgets/glass_widgets.dart';
import '../../models/models.dart';
import '../../providers/app_providers.dart';

enum PluginTab { installed, community }

class PluginsPage extends ConsumerStatefulWidget {
  const PluginsPage({super.key});

  @override
  ConsumerState<PluginsPage> createState() => _PluginsPageState();
}

class _PluginsPageState extends ConsumerState<PluginsPage> {
  PluginTab _currentTab = PluginTab.installed;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final plugins = ref.watch(pluginsProvider);

    final installedPlugins = plugins;
    final communityPlugins = plugins.where((p) => p.source == '社区').toList();

    final displayPlugins = _currentTab == PluginTab.installed
        ? installedPlugins
        : communityPlugins;

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
                  _BackButton(isDark: isDark),
                  const SizedBox(width: 12),
                  Text(
                    '插件市场',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: isDark ? AppColorsDark.onSurface : AppColors.onSurface,
                    ),
                  ),
                  const Spacer(),
                  _CircularIconButton(
                    icon: Icons.search,
                    isDark: isDark,
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _SegmentedControl(
                currentTab: _currentTab,
                isDark: isDark,
                installedCount: installedPlugins.length,
                communityCount: communityPlugins.length,
                onTabChanged: (tab) => setState(() => _currentTab = tab),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
                itemCount: displayPlugins.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  return _PluginCard(plugin: displayPlugins[index], isDark: isDark);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  final bool isDark;

  const _BackButton({required this.isDark});

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
          onTap: () => Navigator.of(context).pop(),
          child: Icon(
            Icons.arrow_back,
            size: 20,
            color: isDark ? AppColorsDark.onSurfaceVariant : AppColors.onSurfaceVariant,
          ),
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

class _SegmentedControl extends StatelessWidget {
  final PluginTab currentTab;
  final bool isDark;
  final int installedCount;
  final int communityCount;
  final ValueChanged<PluginTab> onTabChanged;

  const _SegmentedControl({
    required this.currentTab,
    required this.isDark,
    required this.installedCount,
    required this.communityCount,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = isDark ? AppColorsDark.primary : AppColors.primary;

    return Container(
      height: 40,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: isDark
            ? Colors.white.withValues(alpha: 0.06)
            : Colors.white.withValues(alpha: 0.45),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.12)
              : Colors.white.withValues(alpha: 0.5),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: _SegmentTab(
              label: '已安装',
              count: installedCount,
              isSelected: currentTab == PluginTab.installed,
              isDark: isDark,
              primaryColor: primaryColor,
              onTap: () => onTabChanged(PluginTab.installed),
            ),
          ),
          Expanded(
            child: _SegmentTab(
              label: '社区',
              count: communityCount,
              isSelected: currentTab == PluginTab.community,
              isDark: isDark,
              primaryColor: primaryColor,
              onTap: () => onTabChanged(PluginTab.community),
            ),
          ),
        ],
      ),
    );
  }
}

class _SegmentTab extends StatelessWidget {
  final String label;
  final int count;
  final bool isSelected;
  final bool isDark;
  final Color primaryColor;
  final VoidCallback onTap;

  const _SegmentTab({
    required this.label,
    required this.count,
    required this.isSelected,
    required this.isDark,
    required this.primaryColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: isSelected
            ? (isDark ? AppColorsDark.primary : AppColors.primary).withValues(alpha: 0.18)
            : Colors.transparent,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(999),
          onTap: onTap,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isSelected
                        ? (isDark ? AppColorsDark.primary : AppColors.primary)
                        : (isDark ? AppColorsDark.onSurfaceVariant : AppColors.onSurfaceVariant),
                  ),
                ),
                const SizedBox(width: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: isSelected
                        ? (isDark ? AppColorsDark.primary : AppColors.primary).withValues(alpha: 0.3)
                        : (isDark
                            ? Colors.white.withValues(alpha: 0.08)
                            : Colors.white.withValues(alpha: 0.6)),
                  ),
                  child: Text(
                    '$count',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? (isDark ? AppColorsDark.primary : AppColors.primary)
                          : (isDark ? AppColorsDark.onSurfaceDim : AppColors.onSurfaceDim),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PluginCard extends StatelessWidget {
  final PluginItem plugin;
  final bool isDark;

  const _PluginCard({required this.plugin, required this.isDark});

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'download':
        return Icons.download_outlined;
      case 'globe':
        return Icons.public_outlined;
      case 'search':
        return Icons.search;
      case 'film':
        return Icons.movie_outlined;
      case 'link':
        return Icons.link_outlined;
      case 'check_circle':
        return Icons.check_circle_outline;
      case 'bar_chart':
        return Icons.bar_chart_outlined;
      default:
        return Icons.extension_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = isDark ? AppColorsDark.primary : AppColors.primary;
    final successColor = isDark ? AppColorsDark.success : AppColors.success;
    final warnColor = isDark ? AppColorsDark.warn : AppColors.warn;

    return GlassCard(
      padding: 14,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: primaryColor.withValues(alpha: 0.15),
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withValues(alpha: 0.2),
                      blurRadius: 8,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Icon(
                  _getIconData(plugin.icon),
                  size: 20,
                  color: primaryColor,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            plugin.name,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: isDark ? AppColorsDark.onSurface : AppColors.onSurface,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          plugin.version,
                          style: TextStyle(
                            fontSize: 12,
                            color: isDark ? AppColorsDark.onSurfaceDim : AppColors.onSurfaceDim,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: primaryColor.withValues(alpha: 0.12),
                          ),
                          child: Text(
                            plugin.source,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        if (plugin.isRunning)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: successColor.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: successColor,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '运行中',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: successColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (!plugin.isRunning)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: (isDark ? AppColorsDark.onSurfaceDim : AppColors.onSurfaceDim).withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '已停用',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: isDark ? AppColorsDark.onSurfaceDim : AppColors.onSurfaceDim,
                              ),
                            ),
                          ),
                        if (plugin.hasUpdate) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: warnColor.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.arrow_upward, size: 12, color: warnColor),
                                const SizedBox(width: 2),
                                Text(
                                  '更新',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: warnColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      plugin.description,
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.4,
                        color: isDark ? AppColorsDark.onSurfaceVariant : AppColors.onSurfaceVariant,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            height: 1,
            color: isDark ? Colors.white.withValues(alpha: 0.08) : Colors.white.withValues(alpha: 0.4),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _OutlinedButton(
                  text: plugin.isRunning ? '禁用' : '启用',
                  isDark: isDark,
                  onTap: () {},
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _FilledButton(
                  text: '详情',
                  isDark: isDark,
                  onTap: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _OutlinedButton extends StatelessWidget {
  final String text;
  final bool isDark;
  final VoidCallback onTap;

  const _OutlinedButton({
    required this.text,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final outlineColor = isDark ? AppColorsDark.onSurfaceVariant : AppColors.onSurfaceVariant;

    return Container(
      height: 36,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: outlineColor.withValues(alpha: 0.4),
          width: 1,
        ),
        color: Colors.transparent,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(999),
          onTap: onTap,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: outlineColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FilledButton extends StatelessWidget {
  final String text;
  final bool isDark;
  final VoidCallback onTap;

  const _FilledButton({
    required this.text,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = isDark ? AppColorsDark.primary : AppColors.primary;
    final onPrimaryColor = isDark ? AppColorsDark.onPrimary : AppColors.onPrimary;

    return Container(
      height: 36,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        gradient: LinearGradient(
          colors: isDark
              ? [AppColorsDark.primaryDark, AppColorsDark.primary]
              : [AppColors.primaryDark, AppColors.primary],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: AppGlass.shadowSmall(isDark),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(999),
          onTap: onTap,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: onPrimaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
