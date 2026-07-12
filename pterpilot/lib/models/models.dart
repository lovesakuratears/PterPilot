import 'package:flutter/material.dart';

class Movie {
  final String id;
  final String title;
  final String cover;
  final double doubanRating;
  final double? tmdbRating;
  final int? rank;
  final String year;
  final String? region;
  final List<String>? genres;
  final List<String>? directors;
  final List<String>? actors;
  final String? summary;
  final String? runtime;
  final String? quote;
  final String? ratingCount;
  final String? releaseDate;
  final String? wishCount;

  const Movie({
    required this.id,
    required this.title,
    required this.cover,
    required this.doubanRating,
    this.tmdbRating,
    this.rank,
    required this.year,
    this.region,
    this.genres,
    this.directors,
    this.actors,
    this.summary,
    this.runtime,
    this.quote,
    this.ratingCount,
    this.releaseDate,
    this.wishCount,
  });

  double get derivedTmdb => tmdbRating ?? (doubanRating * 0.85 + 1.2).clamp(0, 10);

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        id: json['id']?.toString() ?? '',
        title: json['title']?.toString() ?? '',
        cover: json['cover']?.toString() ?? '',
        doubanRating: (json['rating'] ?? json['doubanRating'] ?? 0).toDouble(),
        tmdbRating: json['tmdbRating']?.toDouble(),
        rank: json['rank']?.toInt(),
        year: json['year']?.toString() ?? '',
        region: json['region']?.toString(),
        genres: (json['genres'] as List?)?.map((e) => e.toString()).toList(),
        directors: (json['directors'] as List?)?.map((e) => e.toString()).toList(),
        actors: (json['actors'] as List?)?.map((e) => e.toString()).toList(),
        summary: json['summary']?.toString(),
        runtime: json['runtime']?.toString(),
        quote: json['quote']?.toString(),
        ratingCount: json['ratingCount']?.toString(),
        releaseDate: json['releaseDate']?.toString(),
        wishCount: json['wishCount']?.toString(),
      );
}

class Site {
  final String name;
  final String url;
  final String favicon;
  final SiteStatus status;
  final String? vipLevel;
  final String magic;
  final String upload;
  final String download;
  final String ratio;

  const Site({
    required this.name,
    required this.url,
    required this.favicon,
    required this.status,
    this.vipLevel,
    required this.magic,
    required this.upload,
    required this.download,
    required this.ratio,
  });
}

enum SiteStatus { online, offline, cf }

class Torrent {
  final String id;
  final String title;
  final String site;
  final Color siteColor;
  final String size;
  final int seeders;
  final int leechers;
  final String date;
  final String? promo;

  const Torrent({
    required this.id,
    required this.title,
    required this.site,
    required this.siteColor,
    required this.size,
    required this.seeders,
    required this.leechers,
    required this.date,
    this.promo,
  });
}

class DownloadTask {
  final String id;
  final String title;
  final double progress;
  final DownloadStatus status;
  final String size;
  final String? downloadSpeed;
  final String? uploadSpeed;
  final String? remaining;
  final double? ratio;

  const DownloadTask({
    required this.id,
    required this.title,
    required this.progress,
    required this.status,
    required this.size,
    this.downloadSpeed,
    this.uploadSpeed,
    this.remaining,
    this.ratio,
  });
}

enum DownloadStatus { downloading, seeding, paused, error }

class PluginItem {
  final String name;
  final String version;
  final String source;
  final String icon;
  final String description;
  final bool isRunning;
  final bool hasUpdate;

  const PluginItem({
    required this.name,
    required this.version,
    required this.source,
    required this.icon,
    required this.description,
    required this.isRunning,
    this.hasUpdate = false,
  });
}

enum DiscoverCategory { hot, trending, top250, coming }
