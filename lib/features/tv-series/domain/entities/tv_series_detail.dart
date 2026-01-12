import 'package:ditonton/features/movie/domain/entities/genre.dart';
import 'package:equatable/equatable.dart';
import 'season.dart';

class TvSeriesDetail extends Equatable {
  final int id;
  final String name;
  final String posterPath;
  final String backdropPath;
  final double voteAverage;
  final String overview;
  final String firstAirDate;
  final List<Genre> genres;
  final List<int> episodeRunTime;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final List<Season> seasons;

  const TvSeriesDetail({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.backdropPath,
    required this.voteAverage,
    required this.overview,
    required this.firstAirDate,
    required this.genres,
    required this.episodeRunTime,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.seasons,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        posterPath,
        backdropPath,
        voteAverage,
        overview,
        firstAirDate,
        genres,
        episodeRunTime,
        numberOfEpisodes,
        numberOfSeasons,
        seasons,
      ];
}