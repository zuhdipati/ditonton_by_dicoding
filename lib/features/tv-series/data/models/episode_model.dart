import 'package:ditonton/features/tv-series/domain/entities/episode.dart';
import 'package:equatable/equatable.dart';

class EpisodeModel extends Equatable {
  final int id;
  final String name;
  final String overview;
  final int episodeNumber;
  final String? stillPath;
  final String? airDate;
  final double voteAverage;

  const EpisodeModel({
    required this.id,
    required this.name,
    required this.overview,
    required this.episodeNumber,
    this.stillPath,
    this.airDate,
    required this.voteAverage,
  });

  factory EpisodeModel.fromJson(Map<String, dynamic> json) {
    return EpisodeModel(
      id: json['id'],
      name: json['name'] ?? '',
      overview: json['overview'] ?? '',
      episodeNumber: json['episode_number'] ?? 0,
      stillPath: json['still_path'],
      airDate: json['air_date'],
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'overview': overview,
      'episode_number': episodeNumber,
      'still_path': stillPath,
      'air_date': airDate,
      'vote_average': voteAverage,
    };
  }

  Episode toEntity() {
    return Episode(
      id: id,
      name: name,
      overview: overview,
      episodeNumber: episodeNumber,
      stillPath: stillPath,
      airDate: airDate,
      voteAverage: voteAverage,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    overview,
    episodeNumber,
    stillPath,
    airDate,
    voteAverage,
  ];
}
