import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/app_colors.dart';
import '../../widgets/glass_widgets.dart';
import '../../providers/app_providers.dart';

class MovieDetailPage extends ConsumerWidget {
  final String movieId;

  const MovieDetailPage({super.key, required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final movie = ref.watch(movieDetailProvider(movieId));

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: isDark ? AppGradients.bgDark : AppGradients.bgLight,
            ),
          ),
          Column(
            children: [
              _HeroBanner(
                movie: movie,
                onBack: () => Navigator.of(context).pop(),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _RatingCard(
                              rating: movie.derivedTmdb,
                              label: 'TMDB',
                              color: isDark ? AppColorsDark.warn : AppColors.warn,
                              isDark: isDark,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _RatingCard(
                              rating: movie.doubanRating,
                              label: '豆瓣',
                              color: isDark ? AppColorsDark.success : AppColors.success,
                              isDark: isDark,
                              showEmpty: movie.doubanRating == 0,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      if (movie.genres != null && movie.genres!.isNotEmpty) ...[
                        SizedBox(
                          height: 32,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: movie.genres!.length,
                            separatorBuilder: (_, __) => const SizedBox(width: 8),
                            itemBuilder: (context, index) {
                              return _GenreChip(label: movie.genres![index]);
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                      GlassCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '简介',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: isDark ? AppColorsDark.onSurface : AppColors.onSurface,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              movie.summary ?? '暂无简介',
                              style: TextStyle(
                                fontSize: 14,
                                height: 1.6,
                                color: isDark
                                    ? AppColorsDark.onSurfaceVariant
                                    : AppColors.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      if (movie.directors != null && movie.directors!.isNotEmpty) ...[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 48,
                              child: Text(
                                '导演',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: isDark ? AppColorsDark.onSurface : AppColors.onSurface,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: movie.directors!
                                    .map((e) => _PersonChip(name: e))
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                      ],
                      if (movie.actors != null && movie.actors!.isNotEmpty) ...[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 48,
                              child: Text(
                                '主演',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: isDark ? AppColorsDark.onSurface : AppColors.onSurface,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: movie.actors!
                                    .map((e) => _PersonChip(name: e))
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _BottomCTA(
              movieTitle: movie.title,
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroBanner extends StatelessWidget {
  final dynamic movie;
  final VoidCallback onBack;

  const _HeroBanner({
    required this.movie,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      height: 280,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDark
                    ? [const Color(0xFF1A3A35), const Color(0xFF0D1F22), const Color(0xFF142826)]
                    : [const Color(0xFFB8E6DD), const Color(0xFF7FCFC1), const Color(0xFFA8DDD3)],
              ),
            ),
          ),
          if (movie.cover.isNotEmpty)
            Positioned(
              top: 60,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  height: 180,
                  width: 128,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      movie.cover,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: isDark ? const Color(0xFF1A2422) : const Color(0xFFE8EEED),
                        child: Icon(
                          Icons.movie_outlined,
                          size: 40,
                          color: isDark ? AppColorsDark.onSurfaceDim : AppColors.onSurfaceDim,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.75),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  _buildSubtitle(movie),
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 44,
            left: 12,
            child: _BackButton(onTap: onBack),
          ),
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: IOSStatusBar(textColor: Colors.white),
          ),
        ],
      ),
    );
  }

  String _buildSubtitle(dynamic movie) {
    final parts = <String>[];
    if (movie.year != null && movie.year.isNotEmpty) {
      parts.add(movie.year);
    }
    if (movie.region != null && movie.region!.isNotEmpty) {
      parts.add(movie.region!);
    }
    if (movie.genres != null && movie.genres!.isNotEmpty) {
      parts.add(movie.genres!.take(3).join(' / '));
    }
    if (movie.runtime != null && movie.runtime!.isNotEmpty) {
      parts.add(movie.runtime!);
    }
    return parts.join(' · ');
  }
}

class _BackButton extends StatelessWidget {
  final VoidCallback onTap;

  const _BackButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black.withValues(alpha: 0.35),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        shape: const CircleBorder(),
        child: InkWell(
          onTap: onTap,
          customBorder: const CircleBorder(),
          child: const Icon(
            Icons.arrow_back_ios_new,
            size: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class _RatingCard extends StatelessWidget {
  final double rating;
  final String label;
  final Color color;
  final bool isDark;
  final bool showEmpty;

  const _RatingCard({
    required this.rating,
    required this.label,
    required this.color,
    required this.isDark,
    this.showEmpty = false,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: 14,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.star, size: 18, color: color),
              const SizedBox(width: 6),
              Text(
                showEmpty ? '暂无' : rating.toStringAsFixed(1),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: isDark
                  ? AppColorsDark.onSurfaceVariant
                  : AppColors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _GenreChip extends StatelessWidget {
  final String label;

  const _GenreChip({required this.label});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = isDark ? AppColorsDark.primary : AppColors.primary;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: primary.withValues(alpha: 0.12),
        border: Border.all(
          color: primary.withValues(alpha: 0.2),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: primary,
        ),
      ),
    );
  }
}

class _PersonChip extends StatelessWidget {
  final String name;

  const _PersonChip({required this.name});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: isDark
            ? const Color(0xFF141E1C).withValues(alpha: 0.55)
            : Colors.white.withValues(alpha: 0.55),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.12)
              : Colors.white.withValues(alpha: 0.5),
        ),
      ),
      child: Text(
        name,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: isDark ? AppColorsDark.onSurface : AppColors.onSurface,
        ),
      ),
    );
  }
}

class _BottomCTA extends StatelessWidget {
  final String movieTitle;
  final VoidCallback onTap;

  const _BottomCTA({
    required this.movieTitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = isDark ? AppColorsDark.primary : AppColors.primary;
    final onPrimary = isDark ? AppColorsDark.onPrimary : AppColors.onPrimary;

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF0A0F0E).withValues(alpha: 0.75)
            : const Color(0xFFF4F8F7).withValues(alpha: 0.75),
        border: Border(
          top: BorderSide(
            color: isDark
                ? Colors.white.withValues(alpha: 0.08)
                : Colors.white.withValues(alpha: 0.5),
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 52,
          width: double.infinity,
          child: FilledButton.icon(
            onPressed: onTap,
            icon: const Icon(Icons.search, size: 20),
            label: const Text(
              '搜索 PT 资源',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            style: FilledButton.styleFrom(
              backgroundColor: primary,
              foregroundColor: onPrimary,
              shape: const StadiumBorder(),
            ),
          ),
        ),
      ),
    );
  }
}
