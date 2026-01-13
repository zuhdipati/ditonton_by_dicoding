part of 'popular_tv_series_bloc.dart';

sealed class PopularTvSeriesEvent {
  const PopularTvSeriesEvent();
}

class OnGetPopularTvSeries extends PopularTvSeriesEvent {}
