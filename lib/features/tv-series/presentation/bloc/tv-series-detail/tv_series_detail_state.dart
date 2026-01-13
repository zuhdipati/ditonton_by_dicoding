part of 'tv_series_detail_bloc.dart';

class TvSeriesDetailInitial extends TvSeriesDetailState {}

class TvSeriesDetailState extends Equatable {
  final TvSeriesDetail? tvSeriesDetail;
  final RequestState tvSeriesDetailState;
  final List<TvSeries> tvSeriesRecommendations;
  final RequestState tvSeriesRecommendationState;
  final bool isAddedToWatchlist;
  final String watchlistMessage;
  final String message;

  const TvSeriesDetailState({
    this.tvSeriesDetail,
    this.tvSeriesDetailState = RequestState.Empty,
    this.tvSeriesRecommendations = const [],
    this.tvSeriesRecommendationState = RequestState.Empty,
    this.isAddedToWatchlist = false,
    this.watchlistMessage = '',
    this.message = '',
  });

  TvSeriesDetailState copyWith({
    TvSeriesDetail? tvSeriesDetail,
    RequestState? tvSeriesDetailState,
    List<TvSeries>? tvSeriesRecommendations,
    RequestState? tvSeriesRecommendationState,
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
    isAddedToWatchlist,
    watchlistMessage,
    message,
  ];
}
