part of 'popular_tv_series_bloc.dart';

sealed class PopularTvSeriesState extends Equatable {
  const PopularTvSeriesState();

  @override
  List<Object> get props => [];
}

final class PopularTvSeriesInitial extends PopularTvSeriesState {}

class PopularTvSeriesLoading extends PopularTvSeriesState {}

class PopularTvSeriesLoaded extends PopularTvSeriesState {
  final List<TvSeries> tvSeriesList;

  const PopularTvSeriesLoaded(this.tvSeriesList);

  @override
  List<Object> get props => [tvSeriesList];
}

class PopularTvSeriesError extends PopularTvSeriesState {
  final String message;

  const PopularTvSeriesError(this.message);

  @override
  List<Object> get props => [message];
}
