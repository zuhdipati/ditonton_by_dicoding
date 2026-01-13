part of 'top_rated_tv_series_bloc.dart';

sealed class TopRatedTvSeriesEvent {
  const TopRatedTvSeriesEvent();
}

class OnGetTopRatedTvSeries extends TopRatedTvSeriesEvent {}
