part of 'tv_series_detail_bloc.dart';

class TvSeriesDetailInitial extends TvSeriesDetailState {}

class TvSeriesDetailState extends Equatable {
  final TvSeriesDetail? tvSeriesDetail;
  final RequestState tvSeriesDetailState;
  final List<TvSeries> tvSeriesRecommendations;
  final RequestState tvSeriesRecommendationState;
  final List<Episode> tvSeriesSeasons;
  final RequestState tvSeriesSeasonState;
  final bool isAddedToWatchlist;
  final String watchlistMessage;
  final String message;

  const TvSeriesDetailState({
    this.tvSeriesDetail,
    this.tvSeriesDetailState = RequestState.Empty,
    this.tvSeriesRecommendations = const [],
    this.tvSeriesRecommendationState = RequestState.Empty,
    this.tvSeriesSeasons = const [],
    this.tvSeriesSeasonState = RequestState.Empty,
    this.isAddedToWatchlist = false,
    this.watchlistMessage = '',
    this.message = '',
  });

  TvSeriesDetailState copyWith({
    TvSeriesDetail? tvSeriesDetail,
    RequestState? tvSeriesDetailState,
    List<TvSeries>? tvSeriesRecommendations,
    RequestState? tvSeriesRecommendationState,
    List<Episode>? tvSeriesSeasons,
    RequestState? tvSeriesSeasonState,
    bool? isAddedToWatchlist,
    String? watchlistMessage,
    String? message,
  }) {
    return TvSeriesDetailState(
      tvSeriesDetail: tvSeriesDetail ?? this.tvSeriesDetail,
      tvSeriesDetailState: tvSeriesDetailState ?? this.tvSeriesDetailState,
      tvSeriesRecommendations:
          tvSeriesRecommendations ?? this.tvSeriesRecommendations,
      tvSeriesRecommendationState:
          tvSeriesRecommendationState ?? this.tvSeriesRecommendationState,
      tvSeriesSeasons: tvSeriesSeasons ?? this.tvSeriesSeasons,
      tvSeriesSeasonState: tvSeriesSeasonState ?? this.tvSeriesSeasonState,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
    tvSeriesDetail,
    tvSeriesDetailState,
    tvSeriesRecommendations,
    tvSeriesRecommendationState,
    tvSeriesSeasons,
    tvSeriesSeasonState,
    isAddedToWatchlist,
    watchlistMessage,
    message,
  ];
}
