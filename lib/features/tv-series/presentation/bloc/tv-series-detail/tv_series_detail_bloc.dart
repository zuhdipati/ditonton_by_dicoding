import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/tv-series/domain/entities/tv_series.dart';
import 'package:ditonton/features/tv-series/domain/entities/tv_series_detail.dart';
import 'package:ditonton/features/tv-series/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton/features/tv-series/domain/usecases/get_tv_series_recomendations.dart';
import 'package:ditonton/features/tv-series/domain/usecases/get_watchlist_tv_series_status.dart';
import 'package:ditonton/features/tv-series/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:ditonton/features/tv-series/domain/usecases/save_watchlist_tv_series.dart';
import 'package:equatable/equatable.dart';

part 'tv_series_detail_event.dart';
part 'tv_series_detail_state.dart';

class TvSeriesDetailBloc
    extends Bloc<TvSeriesDetailEvent, TvSeriesDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTvSeriesDetail getTvSeriesDetail;
  final GetTvSeriesRecommendations getTvSeriesRecommendations;
  final GetWatchlistTvSeriesStatus getWatchlistTvSeriesStatus;
  final SaveWatchlistTvSeries saveWatchlistTvSeries;
  final RemoveWatchlistTvSeries removeWatchlistTvSeries;

  TvSeriesDetailBloc({
    required this.getTvSeriesDetail,
    required this.getTvSeriesRecommendations,
    required this.getWatchlistTvSeriesStatus,
    required this.saveWatchlistTvSeries,
    required this.removeWatchlistTvSeries,
  }) : super(TvSeriesDetailInitial()) {
    on<OnGetTvSeriesDetail>(_onGetTvSeriesDetail);
    on<OnGetTvSeriesRecommendations>(_onGetTvSeriesRecommendations);
    on<OnGetWatchlistStatus>(_onGetWatchlistStatus);
    on<OnSaveWatchlist>(_onSaveWatchlist);
    on<OnRemoveWatchlist>(_onRemoveWatchlist);
  }

  FutureOr<void> _onGetTvSeriesDetail(
    OnGetTvSeriesDetail event,
    Emitter<TvSeriesDetailState> emit,
  ) async {
    emit(state.copyWith(tvSeriesDetailState: RequestState.Loading));

    final result = await getTvSeriesDetail.execute(event.id);

    result.fold(
      (failure) => emit(
        state.copyWith(
          message: failure.message,
          tvSeriesDetailState: RequestState.Error,
        ),
      ),
      (tvSeriesDetail) => emit(
        state.copyWith(
          tvSeriesDetail: tvSeriesDetail,
          tvSeriesDetailState: RequestState.Loaded,
        ),
      ),
    );
  }

  FutureOr<void> _onGetTvSeriesRecommendations(
    OnGetTvSeriesRecommendations event,
    Emitter<TvSeriesDetailState> emit,
  ) async {
    emit(state.copyWith(tvSeriesRecommendationState: RequestState.Loading));

    final result = await getTvSeriesRecommendations.execute(event.id);

    result.fold(
      (failure) => emit(
        state.copyWith(
          message: failure.message,
          tvSeriesRecommendationState: RequestState.Error,
        ),
      ),
      (tvSeriesList) => emit(
        state.copyWith(
          tvSeriesRecommendations: tvSeriesList,
          tvSeriesRecommendationState: RequestState.Loaded,
        ),
      ),
    );
  }

  FutureOr<void> _onGetWatchlistStatus(
    OnGetWatchlistStatus event,
    Emitter<TvSeriesDetailState> emit,
  ) async {
    final result = await getWatchlistTvSeriesStatus.execute(event.id);

    result.fold(
      (failure) => emit(state.copyWith(isAddedToWatchlist: false)),
      (isAdded) => emit(state.copyWith(isAddedToWatchlist: isAdded)),
    );
  }

  FutureOr<void> _onSaveWatchlist(
    OnSaveWatchlist event,
    Emitter<TvSeriesDetailState> emit,
  ) async {
    final result = await saveWatchlistTvSeries.execute(event.tvSeries);

    result.fold(
      (failure) => emit(state.copyWith(watchlistMessage: failure.message)),
      (message) => emit(
        state.copyWith(watchlistMessage: message, isAddedToWatchlist: true),
      ),
    );
  }

  FutureOr<void> _onRemoveWatchlist(
    OnRemoveWatchlist event,
    Emitter<TvSeriesDetailState> emit,
  ) async {
    final result = await removeWatchlistTvSeries.execute(event.tvSeries);

    result.fold(
      (failure) => emit(state.copyWith(watchlistMessage: failure.message)),
      (message) => emit(
        state.copyWith(watchlistMessage: message, isAddedToWatchlist: false),
      ),
    );
  }
}
