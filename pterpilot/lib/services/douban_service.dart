import 'package:dio/dio.dart';
import '../models/models.dart';

class DoubanService {
  final Dio _dio;

  DoubanService({Dio? dio})
      : _dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: 'https://frodo.douban.com/api/v2',
                headers: {
                  'User-Agent':
                      'Mozilla/5.0 (iPhone; CPU iPhone OS 15_0 like Mac OS X)',
                },
                connectTimeout: const Duration(seconds: 15),
                receiveTimeout: const Duration(seconds: 15),
              ),
            );

  Future<List<Movie>> getTop250({int start = 0, int count = 20}) async {
    try {
      final resp = await _dio.get(
        '/movie/top250',
        queryParameters: {'start': start, 'count': count},
      );
      final subjects = resp.data['subjects'] as List? ?? [];
      return subjects
          .map((e) => Movie.fromJson({
                'id': e['id'],
                'title': e['title'],
                'cover': e['cover_url'] ?? e['images']?['medium'] ?? '',
                'rating': e['rating']?['value']?.toDouble() ?? 0,
                'year': e['year']?.toString() ?? '',
                'ratingCount': e['rating']?['count']?.toString(),
              }))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<List<Movie>> searchMovies(String query, {int start = 0, int count = 20}) async {
    try {
      final resp = await _dio.get(
        '/search/movie',
        queryParameters: {'q': query, 'start': start, 'count': count},
      );
      final subjects = resp.data['items'] as List? ?? [];
      return subjects
          .map((e) {
            final subj = e['target'] ?? e;
            return Movie.fromJson({
              'id': subj['id'],
              'title': subj['title'],
              'cover': subj['cover_url'] ?? subj['images']?['medium'] ?? '',
              'rating': subj['rating']?['value']?.toDouble() ?? 0,
              'year': subj['year']?.toString() ?? '',
            });
          })
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<Movie?> getMovieDetail(String id) async {
    try {
      final resp = await _dio.get('/movie/$id');
      final data = resp.data;
      return Movie.fromJson({
        'id': data['id'],
        'title': data['title'],
        'cover': data['cover_url'] ?? data['images']?['medium'] ?? '',
        'rating': data['rating']?['value']?.toDouble() ?? 0,
        'year': data['year']?.toString() ?? '',
        'region': (data['countries'] as List?)?.join(' '),
        'genres': data['genres'] as List?,
        'directors': (data['directors'] as List?)?.map((e) => e['name']?.toString() ?? '').toList(),
        'actors': (data['actors'] as List?)?.map((e) => e['name']?.toString() ?? '').toList(),
        'summary': data['intro'],
        'runtime': data['duration']?.toString(),
        'ratingCount': data['rating']?['count']?.toString(),
      });
    } catch (e) {
      return null;
    }
  }

  Future<List<Movie>> getNowPlaying({int start = 0, int count = 20}) async {
    try {
      final resp = await _dio.get(
        '/movie/in_theaters',
        queryParameters: {'start': start, 'count': count},
      );
      final subjects = resp.data['subjects'] as List? ?? [];
      return subjects
          .map((e) => Movie.fromJson({
                'id': e['id'],
                'title': e['title'],
                'cover': e['cover_url'] ?? e['images']?['medium'] ?? '',
                'rating': e['rating']?['value']?.toDouble() ?? 0,
                'year': e['year']?.toString() ?? '',
              }))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<List<Movie>> getComingSoon({int start = 0, int count = 20}) async {
    try {
      final resp = await _dio.get(
        '/movie/coming_soon',
        queryParameters: {'start': start, 'count': count},
      );
      final subjects = resp.data['subjects'] as List? ?? [];
      return subjects
          .map((e) => Movie.fromJson({
                'id': e['id'],
                'title': e['title'],
                'cover': e['cover_url'] ?? e['images']?['medium'] ?? '',
                'rating': 0.0,
                'year': e['year']?.toString() ?? '',
                'releaseDate': e['pubdate']?.toString(),
                'wishCount': e['wish_count']?.toString(),
              }))
          .toList();
    } catch (e) {
      return [];
    }
  }
}
