import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/models.dart';
import '../data/mock_data.dart';

final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.system);

final discoverCategoryProvider = StateProvider<DiscoverCategory>(
  (ref) => DiscoverCategory.hot,
);

final discoverMoviesProvider = Provider<List<Movie>>((ref) {
  final category = ref.watch(discoverCategoryProvider);
  switch (category) {
    case DiscoverCategory.hot:
      return MockData.nowPlaying;
    case DiscoverCategory.trending:
      return MockData.top250.sublist(0, 10);
    case DiscoverCategory.top250:
      return MockData.top250;
    case DiscoverCategory.coming:
      return MockData.comingSoon;
  }
});

final movieDetailProvider = Provider.family<Movie, String>((ref, id) {
  return MockData.getMovieById(id);
});

final sitesProvider = Provider<List<Site>>((ref) => MockData.sites);

final searchResultsProvider = Provider<List<Torrent>>((ref) => MockData.searchResults);

final searchQueryProvider = StateProvider<String>((ref) => '');

final downloadTasksProvider = Provider<List<DownloadTask>>((ref) => MockData.downloadTasks);

final pluginsProvider = Provider<List<PluginItem>>((ref) => MockData.plugins);

final selectedDownloaderProvider = StateProvider<int>((ref) => 0);

final downloaderListProvider = Provider<List<Map<String, String>>>((ref) => [
  {'name': '家里的NAS', 'type': 'qBittorrent', 'status': 'online'},
  {'name': '备用服务器', 'type': 'Transmission', 'status': 'online'},
]);

final totalMagicProvider = Provider<String>((ref) {
  final sites = ref.watch(sitesProvider);
  int total = 0;
  for (final s in sites) {
    total += int.tryParse(s.magic.replaceAll(',', '')) ?? 0;
  }
  if (total >= 10000) {
    return '${(total / 10000).toStringAsFixed(1)}万';
  }
  return total.toString();
});

final signInRateProvider = Provider<double>((ref) {
  final sites = ref.watch(sitesProvider);
  final online = sites.where((s) => s.status == SiteStatus.online).length;
  return sites.isEmpty ? 0 : online / sites.length;
});

final offlineSitesCountProvider = Provider<int>((ref) {
  return ref.watch(sitesProvider).where((s) => s.status != SiteStatus.online).length;
});

final totalUploadProvider = Provider<String>((ref) {
  final sites = ref.watch(sitesProvider);
  double total = 0;
  for (final s in sites) {
    final num = double.tryParse(s.upload.replaceAll(' TB', '').trim()) ?? 0;
    total += num;
  }
  return '${total.toStringAsFixed(1)} TB';
});
