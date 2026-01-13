part of 'top_rated_tv_series_bloc.dart';

sealed class TopRatedTvSeriesState extends Equatable {
  const TopRatedTvSeriesState();

  @override
  List<Object> get props => [];
}

final class TopRatedTvSeriesInitial extends TopRatedTvSeriesState {}

class TopRatedTvSeriesLoading extends TopRatedTvSeriesState {}

class TopRatedTvSeriesLoaded extends TopRatedTvSeriesState {
  final List<TvSeries> tvSeriesList;

  const TopRatedTvSeriesLoaded(this.tvSeriesList);

  @override
  List<Object> get props => [tvSeriesList];
}

class TopRatedTvSeriesError extends TopRatedTvSeriesState {
  final String message;

  const TopRatedTvSeriesError(this.message);

  @override
  List<Object> get props => [message];
}
