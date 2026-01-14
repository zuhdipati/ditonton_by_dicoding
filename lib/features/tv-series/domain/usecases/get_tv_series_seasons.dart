import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/features/tv-series/domain/entities/episode.dart';
import 'package:ditonton/features/tv-series/domain/repositories/tv_series_repository.dart';

class GetSeasonEpisodes {
  final TvSeriesRepository repository;

  GetSeasonEpisodes(this.repository);

  Future<Either<Failure, List<Episode>>> execute(int id, int seasonNumber) {
    return repository.getSeasonEpisodes(id, seasonNumber);
  }
}
