import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/features/tv-series/domain/repositories/tv_series_repository.dart';

class GetWatchlistTvSeriesStatus {
  final TvSeriesRepository repository;

  GetWatchlistTvSeriesStatus(this.repository);

  Future<Either<Failure, bool>> execute(int id) async {
    return repository.isAddedToWatchlistTvSeries(id);
  }
}
