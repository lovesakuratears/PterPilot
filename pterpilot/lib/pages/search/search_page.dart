import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/app_colors.dart';
import '../../widgets/glass_widgets.dart';
import '../../models/models.dart';
import '../../providers/app_providers.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleSearch() {
    final query = _searchController.text.trim();
    ref.read(searchQueryProvider.notifier).state = query;
    _focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final searchQuery = ref.watch(searchQueryProvider);
    final sites = ref.watch(sitesProvider);
    final results = ref.watch(searchResultsProvider);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: isDark ? AppGradients.bgDark : AppGradients.bgLight,
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              const IOSStatusBar(),
              _buildHeader(isDark),
              _buildSearchBar(isDark),
              _buildSiteStatusRow(sites, isDark),
              _buildFilterBar(results.length, isDark),
              Expanded(
                child: searchQuery.isEmpty
                    ? _buildEmptyState(isDark)
                    : _buildResultsList(results, isDark),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: 36,
              height: 36,
              alignment: Alignment.center,
              child: Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: isDark ? AppColorsDark.onSurface : AppColors.onSurface,
              ),
            ),
          ),
          const Spacer(),
          Text(
            '聚合搜索',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isDark ? AppColorsDark.onSurface : AppColors.onSurface,
            ),
          ),
          const Spacer(),
          const SizedBox(width: 36),
        ],
      ),
    );
  }

  Widget _buildSearchBar(bool isDark) {
    final primaryColor = isDark ? AppColorsDark.primary : AppColors.primary;
    final onSurfaceDim = isDark ? AppColorsDark.onSurfaceDim : AppColors.onSurfaceDim;
    final onSurface = isDark ? AppColorsDark.onSurface : AppColors.onSurface;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999),
          color: isDark
              ? const Color(0xFF141E1C).withValues(alpha: 0.55)
              : Colors.white.withValues(alpha: 0.55),
          border: Border.all(
            color: _focusNode.hasFocus
                ? primaryColor.withValues(alpha: 0.5)
                : (isDark
                    ? Colors.white.withValues(alpha: 0.12)
                    : Colors.white.withValues(alpha: 0.5)),
            width: 1,
          ),
          boxShadow: AppGlass.shadowSmall(isDark),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Row(
            children: [
              Icon(Icons.search, size: 18, color: onSurfaceDim),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: _searchController,
                  focusNode: _focusNode,
                  onSubmitted: (_) => _handleSearch(),
                  style: TextStyle(
                    fontSize: 14,
                    color: onSurface,
                  ),
                  decoration: InputDecoration(
                    hintText: '搜索资源...',
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: onSurfaceDim,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: _handleSearch,
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_forward,
                    size: 14,
                    color: isDark ? AppColorsDark.onPrimary : AppColors.onPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSiteStatusRow(List<Site> sites, bool isDark) {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: sites.take(8).length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final site = sites[index];
          return _SiteStatusChip(site: site, isDark: isDark);
        },
      ),
    );
  }

  Widget _buildFilterBar(int count, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Text(
            '共 $count 个结果',
            style: TextStyle(
              fontSize: 12,
              color: isDark ? AppColorsDark.onSurfaceDim : AppColors.onSurfaceDim,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {},
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.sort,
                  size: 14,
                  color: isDark ? AppColorsDark.onSurfaceVariant : AppColors.onSurfaceVariant,
                ),
                const SizedBox(width: 4),
                Text(
                  '做种数↓',
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? AppColorsDark.onSurfaceVariant : AppColors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(bool isDark) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.search_outlined,
            size: 48,
            color: isDark ? AppColorsDark.onSurfaceDim : AppColors.onSurfaceDim,
          ),
          const SizedBox(height: 12),
          Text(
            '输入关键词开始搜索',
            style: TextStyle(
              fontSize: 14,
              color: isDark ? AppColorsDark.onSurfaceDim : AppColors.onSurfaceDim,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsList(List<Torrent> results, bool isDark) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: results.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        return _TorrentCard(torrent: results[index], isDark: isDark);
      },
    );
  }
}

class _SiteStatusChip extends StatefulWidget {
  final Site site;
  final bool isDark;

  const _SiteStatusChip({required this.site, required this.isDark});

  @override
  State<_SiteStatusChip> createState() => _SiteStatusChipState();
}

class _SiteStatusChipState extends State<_SiteStatusChip>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color get _statusColor {
    switch (widget.site.status) {
      case SiteStatus.online:
        return widget.isDark ? AppColorsDark.success : AppColors.success;
      case SiteStatus.cf:
        return widget.isDark ? AppColorsDark.warn : AppColors.warn;
      case SiteStatus.offline:
        return widget.isDark ? AppColorsDark.error : AppColors.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: widget.isDark
            ? const Color(0xFF141E1C).withValues(alpha: 0.55)
            : Colors.white.withValues(alpha: 0.55),
        border: Border.all(
          color: widget.isDark
              ? Colors.white.withValues(alpha: 0.12)
              : Colors.white.withValues(alpha: 0.5),
          width: 1,
        ),
        boxShadow: AppGlass.shadowSmall(widget.isDark),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _statusColor,
                  boxShadow: [
                    BoxShadow(
                      color: _statusColor.withValues(alpha: 0.4 + _controller.value * 0.4),
                      blurRadius: 6 + _controller.value * 4,
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(width: 6),
          Text(
            widget.site.name,
            style: TextStyle(
              fontSize: 12,
              color: widget.isDark
                  ? AppColorsDark.onSurfaceVariant
                  : AppColors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _TorrentCard extends StatelessWidget {
  final Torrent torrent;
  final bool isDark;

  const _TorrentCard({required this.torrent, required this.isDark});

  Color get _promoColor {
    if (torrent.promo == 'FREE') {
      return isDark ? AppColorsDark.success : AppColors.success;
    } else if (torrent.promo == '50%') {
      return isDark ? AppColorsDark.warn : AppColors.warn;
    }
    return isDark ? AppColorsDark.onSurfaceDim : AppColors.onSurfaceDim;
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = isDark ? AppColorsDark.primary : AppColors.primary;
    final successColor = isDark ? AppColorsDark.success : AppColors.success;
    final onSurfaceDim = isDark ? AppColorsDark.onSurfaceDim : AppColors.onSurfaceDim;
    final onSurface = isDark ? AppColorsDark.onSurface : AppColors.onSurface;
    final onPrimary = isDark ? AppColorsDark.onPrimary : AppColors.onPrimary;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: isDark
            ? const Color(0xFF141E1C).withValues(alpha: 0.55)
            : Colors.white.withValues(alpha: 0.55),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.12)
              : Colors.white.withValues(alpha: 0.5),
          width: 1,
        ),
        boxShadow: AppGlass.shadowMedium(isDark),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        torrent.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: onSurface,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: torrent.siteColor,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                torrent.site,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: torrent.siteColor,
                                ),
                              ),
                            ],
                          ),
                          MonoText(
                            torrent.size,
                            fontSize: 12,
                            color: onSurfaceDim,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.arrow_upward, size: 12, color: successColor),
                              const SizedBox(width: 2),
                              Text(
                                '${torrent.seeders}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.arrow_downward, size: 12, color: onSurfaceDim),
                              const SizedBox(width: 2),
                              Text(
                                '${torrent.leechers}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: onSurfaceDim,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            torrent.date,
                            style: TextStyle(
                              fontSize: 12,
                              color: onSurfaceDim,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (torrent.promo != null)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: _promoColor.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          torrent.promo!,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: _promoColor,
                          ),
                        ),
                      ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          '推送',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: onPrimary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
