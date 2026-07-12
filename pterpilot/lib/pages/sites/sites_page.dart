import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/app_colors.dart';
import '../../widgets/glass_widgets.dart';
import '../../models/models.dart';
import '../../providers/app_providers.dart';

enum SortType { magic, upload, ratio, name }

class SitesPage extends ConsumerStatefulWidget {
  const SitesPage({super.key});

  @override
  ConsumerState<SitesPage> createState() => _SitesPageState();
}

class _SitesPageState extends ConsumerState<SitesPage> {
  SortType _sortType = SortType.magic;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final sites = ref.watch(sitesProvider);
    final totalMagic = ref.watch(totalMagicProvider);
    final totalUpload = ref.watch(totalUploadProvider);
    final signInRate = ref.watch(signInRateProvider);
    final offlineCount = ref.watch(offlineSitesCountProvider);

    final sortedSites = [...sites]..sort((a, b) {
        switch (_sortType) {
          case SortType.magic:
            final aVal = int.tryParse(a.magic.replaceAll(',', '')) ?? 0;
            final bVal = int.tryParse(b.magic.replaceAll(',', '')) ?? 0;
            return bVal.compareTo(aVal);
          case SortType.upload:
            final aVal = double.tryParse(a.upload.replaceAll(' TB', '').trim()) ?? 0;
            final bVal = double.tryParse(b.upload.replaceAll(' TB', '').trim()) ?? 0;
            return bVal.compareTo(aVal);
          case SortType.ratio:
            final aVal = double.tryParse(a.ratio.replaceAll('x', '').trim()) ?? 0;
            final bVal = double.tryParse(b.ratio.replaceAll('x', '').trim()) ?? 0;
            return bVal.compareTo(aVal);
          case SortType.name:
            return a.name.compareTo(b.name);
        }
      });

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
                    '站点',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: isDark ? AppColorsDark.onSurface : AppColors.onSurface,
                    ),
                  ),
                  const Spacer(),
                  Container(
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
                    child: Icon(
                      Icons.add,
                      size: 20,
                      color: isDark ? AppColorsDark.primary : AppColors.primary,
                    ),
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
                    _buildKpiGrid(isDark, totalMagic, totalUpload, signInRate, offlineCount),
                    const SizedBox(height: 16),
                    _buildCookieCloudButton(isDark),
                    const SizedBox(height: 16),
                    _buildSortChips(isDark),
                    const SizedBox(height: 16),
                    _buildSiteList(isDark, sortedSites),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKpiGrid(bool isDark, String totalMagic, String totalUpload, double signInRate, int offlineCount) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.4,
      children: [
        _KpiCard(
          value: totalMagic,
          label: '魔力值',
          icon: Icons.auto_awesome,
          accentColor: isDark ? AppColorsDark.magic : AppColors.magic,
          isDark: isDark,
        ),
        _KpiCard(
          value: totalUpload,
          label: '上传量',
          icon: Icons.upload_file,
          accentColor: isDark ? AppColorsDark.info : AppColors.info,
          isDark: isDark,
        ),
        _KpiCard(
          value: '${(signInRate * 100).toStringAsFixed(0)}%',
          label: '签到率',
          icon: Icons.check_circle,
          accentColor: isDark ? AppColorsDark.success : AppColors.success,
          isDark: isDark,
        ),
        _KpiCard(
          value: '$offlineCount',
          label: '异常站点',
          icon: Icons.warning_amber_rounded,
          accentColor: isDark ? AppColorsDark.warn : AppColors.warn,
          isDark: isDark,
        ),
      ],
    );
  }

  Widget _buildCookieCloudButton(bool isDark) {
    return Container(
      height: 48,
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
          onTap: () {},
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.cloud_sync, size: 20, color: isDark ? AppColorsDark.onPrimary : AppColors.onPrimary),
                const SizedBox(width: 8),
                Text(
                  'CookieCloud 同步',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: isDark ? AppColorsDark.onPrimary : AppColors.onPrimary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSortChips(bool isDark) {
    final chips = [
      ('魔力值', SortType.magic),
      ('上传量', SortType.upload),
      ('分享率', SortType.ratio),
      ('名称', SortType.name),
    ];

    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: chips.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final (label, type) = chips[index];
          final isSelected = _sortType == type;
          return _SortChip(
            label: label,
            isSelected: isSelected,
            isDark: isDark,
            onTap: () => setState(() => _sortType = type),
          );
        },
      ),
    );
  }

  Widget _buildSiteList(bool isDark, List<Site> sites) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: sites.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        return _SiteCard(site: sites[index], isDark: isDark);
      },
    );
  }
}

class _KpiCard extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  final Color accentColor;
  final bool isDark;

  const _KpiCard({
    required this.value,
    required this.label,
    required this.icon,
    required this.accentColor,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: 14,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: accentColor.withValues(alpha: 0.15),
            ),
            child: Icon(icon, size: 18, color: accentColor),
          ),
          const Spacer(),
          MonoText(
            value,
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: accentColor,
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isDark ? AppColorsDark.onSurfaceDim : AppColors.onSurfaceDim,
            ),
          ),
        ],
      ),
    );
  }
}

class _SortChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final bool isDark;
  final VoidCallback onTap;

  const _SortChip({
    required this.label,
    required this.isSelected,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: isSelected
            ? (isDark ? AppColorsDark.primary : AppColors.primary).withValues(alpha: 0.15)
            : (isDark
                ? Colors.white.withValues(alpha: 0.06)
                : Colors.white.withValues(alpha: 0.45)),
        border: Border.all(
          color: isSelected
              ? (isDark ? AppColorsDark.primary : AppColors.primary).withValues(alpha: 0.4)
              : (isDark
                  ? Colors.white.withValues(alpha: 0.12)
                  : Colors.white.withValues(alpha: 0.5)),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(999),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: isSelected
                    ? (isDark ? AppColorsDark.primary : AppColors.primary)
                    : (isDark ? AppColorsDark.onSurfaceVariant : AppColors.onSurfaceVariant),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SiteCard extends StatelessWidget {
  final Site site;
  final bool isDark;

  const _SiteCard({required this.site, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final magicColor = isDark ? AppColorsDark.magic : AppColors.magic;
    final primaryColor = isDark ? AppColorsDark.primary : AppColors.primary;

    StatusDot statusDot;
    switch (site.status) {
      case SiteStatus.online:
        statusDot = StatusDot.online(darkMode: isDark);
        break;
      case SiteStatus.offline:
        statusDot = StatusDot.offline(darkMode: isDark);
        break;
      case SiteStatus.cf:
        statusDot = StatusDot.warning(darkMode: isDark);
        break;
    }

    return GlassCard(
      padding: 14,
      child: Row(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [primaryColor.withValues(alpha: 0.3), primaryColor.withValues(alpha: 0.1)],
                  ),
                  border: Border.all(
                    color: isDark ? Colors.white.withValues(alpha: 0.15) : Colors.white.withValues(alpha: 0.6),
                  ),
                ),
                child: Center(
                  child: Text(
                    site.name.characters.first,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: primaryColor,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: -2,
                bottom: -2,
                child: statusDot,
              ),
            ],
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
                        site.name,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: isDark ? AppColorsDark.onSurface : AppColors.onSurface,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (site.vipLevel != null) ...[
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: magicColor.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          site.vipLevel!,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: magicColor,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                MonoText(
                  '${site.upload} · ${site.download} · ${site.ratio}',
                  fontSize: 11,
                  color: isDark ? AppColorsDark.onSurfaceDim : AppColors.onSurfaceDim,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          MonoText(
            site.magic,
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: magicColor,
          ),
        ],
      ),
    );
  }
}
