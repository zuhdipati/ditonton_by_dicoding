import 'package:equatable/equatable.dart';

class Episode extends Equatable {
  final int id;
  final String name;
  final String overview;
  final int episodeNumber;
  final String? stillPath;
  final String? airDate;
  final double voteAverage;

  const Episode({
    required this.id,
    required this.name,
    required this.overview,
    required this.episodeNumber,
    this.stillPath,
    this.airDate,
    required this.voteAverage,
  });

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
