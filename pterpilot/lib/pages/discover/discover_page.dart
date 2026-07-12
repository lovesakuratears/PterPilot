import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/app_colors.dart';
import '../../widgets/glass_widgets.dart';
import '../../models/models.dart';
import '../../providers/app_providers.dart';
import '../detail/movie_detail_page.dart';

class DiscoverPage extends ConsumerWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final category = ref.watch(discoverCategoryProvider);
    final movies = ref.watch(discoverMoviesProvider);
    final themeMode = ref.watch(themeModeProvider);

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
                    '发现',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: isDark ? AppColorsDark.onSurface : AppColors.onSurface,
                    ),
                  ),
                  const Spacer(),
                  _ThemeToggleButton(
                    isDark: isDark,
                    themeMode: themeMode,
                    onTap: () {
                      final next = themeMode == ThemeMode.dark
                          ? ThemeMode.light
                          : ThemeMode.dark;
                      ref.read(themeModeProvider.notifier).state = next;
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _SearchCapsule(
                onTap: () {},
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 36,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: DiscoverCategory.values.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  final cat = DiscoverCategory.values[index];
                  final isSelected = cat == category;
                  return _CategoryChip(
                    label: _categoryLabel(cat),
                    isSelected: isSelected,
                    onTap: () {
                      ref.read(discoverCategoryProvider.notifier).state = cat;
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 120),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  childAspectRatio: 2 / 3.2,
                ),
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return _MovieCard(
                    movie: movie,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => MovieDetailPage(movieId: movie.id),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _categoryLabel(DiscoverCategory cat) {
    switch (cat) {
      case DiscoverCategory.hot:
        return '热门';
      case DiscoverCategory.trending:
        return 'Trending';
      case DiscoverCategory.top250:
        return '豆瓣TOP250';
      case DiscoverCategory.coming:
        return '即将上线';
    }
  }
}

class _ThemeToggleButton extends StatelessWidget {
  final bool isDark;
  final ThemeMode themeMode;
  final VoidCallback onTap;

  const _ThemeToggleButton({
    required this.isDark,
    required this.themeMode,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isDark
            ? const Color(0xFF141E1C).withValues(alpha: 0.55)
            : Colors.white.withValues(alpha: 0.55),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.12)
              : Colors.white.withValues(alpha: 0.5),
        ),
        boxShadow: AppGlass.shadowSmall(isDark),
      ),
      child: Material(
        color: Colors.transparent,
        shape: const CircleBorder(),
        child: InkWell(
          onTap: onTap,
          customBorder: const CircleBorder(),
          child: Icon(
            themeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode,
            size: 20,
            color: isDark ? AppColorsDark.onSurface : AppColors.onSurface,
          ),
        ),
      ),
    );
  }
}

class _SearchCapsule extends StatelessWidget {
  final VoidCallback onTap;

  const _SearchCapsule({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      height: 44,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: isDark
            ? const Color(0xFF141E1C).withValues(alpha: 0.55)
            : Colors.white.withValues(alpha: 0.55),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.12)
              : Colors.white.withValues(alpha: 0.5),
        ),
        boxShadow: AppGlass.shadowSmall(isDark),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(999),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(999),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  size: 20,
                  color: isDark ? AppColorsDark.onSurfaceDim : AppColors.onSurfaceDim,
                ),
                const SizedBox(width: 10),
                Text(
                  '搜索影视 / 直接搜种...',
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark ? AppColorsDark.onSurfaceDim : AppColors.onSurfaceDim,
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

class _CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scheme = Theme.of(context).colorScheme;

    final bgColor = isSelected
        ? (isDark ? scheme.primaryContainer : scheme.primaryContainer)
        : (isDark
            ? const Color(0xFF141E1C).withValues(alpha: 0.55)
            : scheme.surfaceDim.withValues(alpha: 0.5));

    final textColor = isSelected
        ? (isDark ? scheme.onPrimaryContainer : scheme.onPrimaryContainer)
        : (isDark ? AppColorsDark.onSurfaceVariant : AppColors.onSurfaceVariant);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: bgColor,
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.12)
              : Colors.white.withValues(alpha: 0.5),
        ),
        boxShadow: isSelected ? null : AppGlass.shadowSmall(isDark),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(999),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(999),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MovieCard extends StatelessWidget {
  final Movie movie;
  final VoidCallback onTap;

  const _MovieCard({
    required this.movie,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final tmdbColor = isDark ? AppColorsDark.warn : AppColors.warn;
    final doubanColor = isDark ? AppColorsDark.success : AppColors.success;

    return GlassCard(
      onTap: onTap,
      padding: 0,
      borderRadius: 14,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    color: isDark
                        ? const Color(0xFF1A2422)
                        : const Color(0xFFE8EEED),
                    child: movie.cover.isNotEmpty
                        ? Image.network(
                            movie.cover,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              color: isDark
                                  ? const Color(0xFF1A2422)
                                  : const Color(0xFFE8EEED),
                              child: Icon(
                                Icons.movie_outlined,
                                size: 40,
                                color: isDark
                                    ? AppColorsDark.onSurfaceDim
                                    : AppColors.onSurfaceDim,
                              ),
                            ),
                          )
                        : Center(
                            child: Icon(
                              Icons.movie_outlined,
                              size: 40,
                              color: isDark
                                  ? AppColorsDark.onSurfaceDim
                                  : AppColors.onSurfaceDim,
                            ),
                          ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.7),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 8,
                    bottom: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        movie.year,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  if (movie.rank != null)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.9),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '#${movie.rank}',
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isDark ? AppColorsDark.onSurface : AppColors.onSurface,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.star, size: 12, color: tmdbColor),
                    const SizedBox(width: 3),
                    Text(
                      movie.derivedTmdb.toStringAsFixed(1),
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: tmdbColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Icon(Icons.star, size: 12, color: doubanColor),
                    const SizedBox(width: 3),
                    Text(
                      movie.doubanRating > 0
                          ? movie.doubanRating.toStringAsFixed(1)
                          : '暂无',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: doubanColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
