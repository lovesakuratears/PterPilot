import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/app_colors.dart';
import '../../widgets/glass_widgets.dart';
import '../../models/models.dart';
import '../../providers/app_providers.dart';

class DownloaderPage extends ConsumerWidget {
  const DownloaderPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final downloaders = ref.watch(downloaderListProvider);
    final selectedIndex = ref.watch(selectedDownloaderProvider);
    final tasks = ref.watch(downloadTasksProvider);

    return GradientOrbsBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              const IOSStatusBar(),
              _buildHeader(isDark),
              _buildDownloaderChips(downloaders, selectedIndex, ref, isDark),
              _buildConnectionBanner(isDark),
              _buildSearchBar(tasks.length, isDark),
              Expanded(
                child: _buildTaskList(tasks, isDark),
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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: [
          Text(
            '下载器',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isDark ? AppColorsDark.onSurface : AppColors.onSurface,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {},
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: isDark
                    ? const Color(0xFF141E1C).withValues(alpha: 0.45)
                    : Colors.white.withValues(alpha: 0.45),
                border: Border.all(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.12)
                      : Colors.white.withValues(alpha: 0.5),
                  width: 1,
                ),
              ),
              child: Icon(
                Icons.settings_outlined,
                size: 18,
                color: isDark ? AppColorsDark.onSurface : AppColors.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDownloaderChips(
    List<Map<String, String>> downloaders,
    int selectedIndex,
    WidgetRef ref,
    bool isDark,
  ) {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: downloaders.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final downloader = downloaders[index];
          final isSelected = index == selectedIndex;
          final isOnline = downloader['status'] == 'online';
          final type = downloader['type'] == 'qBittorrent' ? 'QB' : 'TR';

          return GestureDetector(
            onTap: () {
              ref.read(selectedDownloaderProvider.notifier).state = index;
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: isSelected
                    ? (isDark
                        ? AppColorsDark.primary.withValues(alpha: 0.15)
                        : AppColors.primary.withValues(alpha: 0.12))
                    : (isDark
                        ? const Color(0xFF141E1C).withValues(alpha: 0.45)
                        : Colors.white.withValues(alpha: 0.45)),
                border: Border.all(
                  color: isSelected
                      ? (isDark
                          ? AppColorsDark.primary.withValues(alpha: 0.25)
                          : AppColors.primary.withValues(alpha: 0.25))
                      : (isDark
                          ? Colors.white.withValues(alpha: 0.12)
                          : Colors.white.withValues(alpha: 0.5)),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isOnline
                          ? (isDark ? AppColorsDark.success : AppColors.success)
                          : (isDark ? AppColorsDark.error : AppColors.error),
                      boxShadow: isOnline
                          ? [
                              BoxShadow(
                                color: (isDark ? AppColorsDark.success : AppColors.success)
                                    .withValues(alpha: 0.6),
                                blurRadius: 6,
                              ),
                            ]
                          : null,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${downloader['name']} · $type',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: isSelected
                          ? (isDark ? AppColorsDark.primary : AppColors.primary)
                          : (isDark
                              ? AppColorsDark.onSurfaceVariant
                              : AppColors.onSurfaceVariant),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildConnectionBanner(bool isDark) {
    final primaryColor = isDark ? AppColorsDark.primary : AppColors.primary;
    final successColor = isDark ? AppColorsDark.success : AppColors.success;
    final onSurfaceDim = isDark ? AppColorsDark.onSurfaceDim : AppColors.onSurfaceDim;
    final onSurfaceVariant = isDark ? AppColorsDark.onSurfaceVariant : AppColors.onSurfaceVariant;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: isDark
              ? const Color(0xFF141E1C).withValues(alpha: 0.45)
              : Colors.white.withValues(alpha: 0.45),
          border: Border.all(
            color: isDark
                ? Colors.white.withValues(alpha: 0.12)
                : Colors.white.withValues(alpha: 0.5),
            width: 1,
          ),
          boxShadow: AppGlass.shadowSmall(isDark),
        ),
        child: Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: successColor,
                boxShadow: [
                  BoxShadow(
                    color: successColor.withValues(alpha: 0.6),
                    blurRadius: 6,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '已连接',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: successColor,
              ),
            ),
            const Spacer(),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                MonoText(
                  '↓ 8.2',
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: primaryColor,
                ),
                const SizedBox(width: 2),
                Text(
                  'MB/s',
                  style: TextStyle(
                    fontSize: 12,
                    color: onSurfaceVariant,
                  ),
                ),
                const SizedBox(width: 8),
                MonoText(
                  '↑ 1.1',
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: onSurfaceDim,
                ),
                const SizedBox(width: 2),
                Text(
                  'MB/s',
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
    );
  }

  Widget _buildSearchBar(int count, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: [
          Text(
            '种子任务 ($count)',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: isDark ? AppColorsDark.onSurface : AppColors.onSurface,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {},
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: isDark
                    ? const Color(0xFF141E1C).withValues(alpha: 0.45)
                    : Colors.white.withValues(alpha: 0.45),
                border: Border.all(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.12)
                      : Colors.white.withValues(alpha: 0.5),
                  width: 1,
                ),
              ),
              child: Icon(
                Icons.search,
                size: 16,
                color: isDark ? AppColorsDark.onSurfaceVariant : AppColors.onSurfaceVariant,
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: isDark
                    ? const Color(0xFF141E1C).withValues(alpha: 0.45)
                    : Colors.white.withValues(alpha: 0.45),
                border: Border.all(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.12)
                      : Colors.white.withValues(alpha: 0.5),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.check_box_outlined,
                    size: 14,
                    color: isDark
                        ? AppColorsDark.onSurfaceVariant
                        : AppColors.onSurfaceVariant,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '批量',
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
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskList(List<DownloadTask> tasks, bool isDark) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: tasks.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        return _DownloadTaskCard(task: tasks[index], isDark: isDark);
      },
    );
  }
}

class _DownloadTaskCard extends StatelessWidget {
  final DownloadTask task;
  final bool isDark;

  const _DownloadTaskCard({required this.task, required this.isDark});

  Color get _statusColor {
    switch (task.status) {
      case DownloadStatus.downloading:
        return isDark ? AppColorsDark.primary : AppColors.primary;
      case DownloadStatus.seeding:
        return isDark ? AppColorsDark.success : AppColors.success;
      case DownloadStatus.paused:
        return isDark ? AppColorsDark.onSurfaceDim : AppColors.onSurfaceDim;
      case DownloadStatus.error:
        return isDark ? AppColorsDark.error : AppColors.error;
    }
  }

  String get _statusText {
    switch (task.status) {
      case DownloadStatus.downloading:
        return '下载中';
      case DownloadStatus.seeding:
        return '做种中';
      case DownloadStatus.paused:
        return '已暂停';
      case DownloadStatus.error:
        return '错误';
    }
  }

  @override
  Widget build(BuildContext context) {
    final onSurface = isDark ? AppColorsDark.onSurface : AppColors.onSurface;
    final onSurfaceVariant = isDark ? AppColorsDark.onSurfaceVariant : AppColors.onSurfaceVariant;
    final onSurfaceDim = isDark ? AppColorsDark.onSurfaceDim : AppColors.onSurfaceDim;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: isDark
            ? const Color(0xFF141E1C).withValues(alpha: 0.45)
            : Colors.white.withValues(alpha: 0.45),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.12)
              : Colors.white.withValues(alpha: 0.5),
          width: 1,
        ),
        boxShadow: AppGlass.shadowSmall(isDark),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        task.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: onSurface,
                          height: 1.3,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: _statusColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        _statusText,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: _statusColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                if (task.status == DownloadStatus.downloading ||
                    task.status == DownloadStatus.paused)
                  _buildProgressBar(),
                if (task.status == DownloadStatus.downloading ||
                    task.status == DownloadStatus.paused)
                  const SizedBox(height: 8),
                _buildStatusInfo(),
                const SizedBox(height: 10),
                _buildActionButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProgressBar() {
    final bgColor = isDark
        ? Colors.white.withValues(alpha: 0.08)
        : Colors.black.withValues(alpha: 0.06);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            color: bgColor,
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: task.progress,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999),
                color: task.status == DownloadStatus.paused
                    ? (isDark ? AppColorsDark.onSurfaceDim : AppColors.onSurfaceDim)
                        .withValues(alpha: 0.5)
                    : _statusColor,
                boxShadow: task.status == DownloadStatus.downloading
                    ? [
                        BoxShadow(
                          color: _statusColor.withValues(alpha: 0.5),
                          blurRadius: 4,
                        ),
                      ]
                    : null,
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            MonoText(
              '${(task.progress * 100).toStringAsFixed(1)}%',
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: task.status == DownloadStatus.paused
                  ? (isDark ? AppColorsDark.onSurfaceDim : AppColors.onSurfaceDim)
                  : _statusColor,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatusInfo() {
    final onSurfaceDim = isDark ? AppColorsDark.onSurfaceDim : AppColors.onSurfaceDim;
    final onSurfaceVariant = isDark ? AppColorsDark.onSurfaceVariant : AppColors.onSurfaceVariant;

    switch (task.status) {
      case DownloadStatus.downloading:
        return Row(
          children: [
            MonoText(
              '↓${task.downloadSpeed ?? ''}',
              fontSize: 12,
              color: _statusColor,
            ),
            const SizedBox(width: 8),
            MonoText(
              '↑${task.uploadSpeed ?? ''}',
              fontSize: 12,
              color: onSurfaceVariant,
            ),
            const Spacer(),
            MonoText(
              'ETA ${task.remaining ?? ''}',
              fontSize: 12,
              color: onSurfaceDim,
            ),
          ],
        );
      case DownloadStatus.seeding:
        return Row(
          children: [
            MonoText(
              '分享率 ${task.ratio?.toStringAsFixed(2) ?? '0.00'}',
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: _statusColor,
            ),
            const Spacer(),
            MonoText(
              '↑${task.uploadSpeed ?? '0 KB/s'}',
              fontSize: 12,
              color: onSurfaceDim,
            ),
          ],
        );
      case DownloadStatus.paused:
      case DownloadStatus.error:
        return Row(
          children: [
            MonoText(
              task.size,
              fontSize: 12,
              color: onSurfaceDim,
            ),
          ],
        );
    }
  }

  Widget _buildActionButtons() {
    final onSurfaceDim = isDark ? AppColorsDark.onSurfaceDim : AppColors.onSurfaceDim;

    return Row(
      children: [
        _ActionButton(
          icon: task.status == DownloadStatus.paused
              ? Icons.play_arrow
              : Icons.pause,
          label: task.status == DownloadStatus.paused ? '恢复' : '暂停',
          isDark: isDark,
          onTap: () {},
        ),
        const SizedBox(width: 8),
        _ActionButton(
          icon: Icons.delete_outline,
          label: '删除',
          isDark: isDark,
          color: isDark ? AppColorsDark.error : AppColors.error,
          onTap: () {},
        ),
        const SizedBox(width: 8),
        _ActionButton(
          icon: Icons.info_outline,
          label: '详情',
          isDark: isDark,
          onTap: () {},
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isDark;
  final Color? color;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.isDark,
    this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final buttonColor = color ?? (isDark ? AppColorsDark.onSurfaceDim : AppColors.onSurfaceDim);

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: isDark
                ? Colors.white.withValues(alpha: 0.06)
                : Colors.black.withValues(alpha: 0.04),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 16, color: buttonColor),
              const SizedBox(width: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: buttonColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
