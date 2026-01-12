import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/movie/domain/entities/movie.dart';
import 'package:ditonton/features/movie/domain/entities/movie_detail.dart';
import 'package:ditonton/features/movie/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/features/movie/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/features/movie/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/features/movie/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/features/movie/domain/usecases/save_watchlist.dart';
import 'package:equatable/equatable.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  GetMovieDetail getMovieDetail;
  GetMovieRecommendations getMovieRecommendations;
  GetWatchListStatus getWatchListStatus;
  SaveWatchlist saveWatchlist;
  RemoveWatchlist removeWatchlist;

  MovieDetailBloc({
    required this.getMovieDetail,
    required this.getMovieRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(MovieDetailInitial()) {
    on<OnGetMovieDetail>(_onGetMovieDetail);
    on<OnGetMovieRecommendations>(_onGetMovieRecommendations);
    on<OnGetWatchlist>(_onGetWatchlist);
    on<OnSaveWatchlist>(_saveWatchlist);
    on<OnRemoveWatchlist>(_removeWatchlist);
  }

  FutureOr<void> _onGetMovieDetail(
    OnGetMovieDetail event,
    Emitter<MovieDetailState> emit,
  ) async {
    emit(state.copyWith(movieDetailState: RequestState.Loading));

    final result = await getMovieDetail.execute(event.id);

    result.fold(
      (failure) => emit(
        state.copyWith(
          message: failure.message,
          movieDetailState: RequestState.Error,
        ),
      ),
      (movieDetail) => emit(
        state.copyWith(
          movieDetail: movieDetail,
          movieDetailState: RequestState.Loaded,
        ),
      ),
    );
  }

  FutureOr<void> _onGetMovieRecommendations(
    OnGetMovieRecommendations event,
    Emitter<MovieDetailState> emit,
  ) async {
    emit(state.copyWith(movieRecommendationState: RequestState.Loading));

    final result = await getMovieRecommendations.execute(event.id);

    result.fold(
      (failure) => emit(
        state.copyWith(
          message: failure.message,
          movieRecommendationState: RequestState.Error,
        ),
      ),
      (movies) => emit(
        state.copyWith(
          movieRecommendations: movies,
          movieRecommendationState: RequestState.Loaded,
        ),
      ),
    );
  }

  FutureOr<void> _onGetWatchlist(
    OnGetWatchlist event,
    Emitter<MovieDetailState> emit,
  ) async {
    final result = await getWatchListStatus.execute(event.id);

    emit(state.copyWith(isAddedToWatchlist: result));
  }

  FutureOr<void> _saveWatchlist(
    OnSaveWatchlist event,
    Emitter<MovieDetailState> emit,
  ) async {
    final result = await saveWatchlist.execute(event.movie);

    result.fold(
      (failure) => emit(state.copyWith(watchlistMessage: failure.message)),
      (message) => emit(
        state.copyWith(watchlistMessage: message, isAddedToWatchlist: true),
      ),
    );
  }

  FutureOr<void> _removeWatchlist(
    OnRemoveWatchlist event,
    Emitter<MovieDetailState> emit,
  ) async {
    final result = await removeWatchlist.execute(event.movie);

    result.fold(
      (failure) => emit(state.copyWith(watchlistMessage: failure.message)),
      (message) => emit(
        state.copyWith(watchlistMessage: message, isAddedToWatchlist: false),
      ),
    );
  }
}
