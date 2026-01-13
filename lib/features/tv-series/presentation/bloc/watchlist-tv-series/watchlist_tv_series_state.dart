part of 'watchlist_tv_series_bloc.dart';

sealed class WatchlistTvSeriesState extends Equatable {
  const WatchlistTvSeriesState();

  @override
  List<Object> get props => [];
}

final class WatchlistTvSeriesInitial extends WatchlistTvSeriesState {}

class WatchlistTvSeriesLoading extends WatchlistTvSeriesState {}

class WatchlistTvSeriesLoaded extends WatchlistTvSeriesState {
  final List<TvSeries> result;

  const WatchlistTvSeriesLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class WatchlistTvSeriesError extends WatchlistTvSeriesState {
  final String message;

  const WatchlistTvSeriesError(this.message);

  @override
  List<Object> get props => [message];
}
