part of 'watchlist_tv_series_bloc.dart';

sealed class WatchlistTvSeriesEvent {
  const WatchlistTvSeriesEvent();
}

class OnGetWatchlistTvSeries extends WatchlistTvSeriesEvent {}
