part of 'tv_series_detail_bloc.dart';

sealed class TvSeriesDetailEvent extends Equatable {
  const TvSeriesDetailEvent();
}

class OnGetTvSeriesDetail extends TvSeriesDetailEvent {
  final int id;

  const OnGetTvSeriesDetail(this.id);

  @override
  List<Object> get props => [id];
}

class OnGetTvSeriesRecommendations extends TvSeriesDetailEvent {
  final int id;

  const OnGetTvSeriesRecommendations(this.id);

  @override
  List<Object> get props => [id];
}

class OnGetWatchlistStatus extends TvSeriesDetailEvent {
  final int id;

  const OnGetWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}

class OnSaveWatchlist extends TvSeriesDetailEvent {
  final TvSeriesDetail tvSeries;

  const OnSaveWatchlist(this.tvSeries);

  @override
  List<Object> get props => [tvSeries];
}

class OnRemoveWatchlist extends TvSeriesDetailEvent {
  final TvSeriesDetail tvSeries;

  const OnRemoveWatchlist(this.tvSeries);

  @override
  List<Object> get props => [tvSeries];
}

class OnGetTvSeriesSeasons extends TvSeriesDetailEvent {
  final int id;
  final int seasonNumber;

  const OnGetTvSeriesSeasons(this.id, this.seasonNumber);

  @override
  List<Object> get props => [id, seasonNumber];
}