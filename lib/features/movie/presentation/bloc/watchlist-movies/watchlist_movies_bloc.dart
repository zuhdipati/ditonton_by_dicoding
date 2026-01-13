import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:ditonton/features/movie/domain/entities/movie.dart';
import 'package:ditonton/features/movie/domain/usecases/get_watchlist_movies.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_movies_event.dart';
part 'watchlist_movies_state.dart';

class WatchlistMoviesBloc
    extends Bloc<WatchlistMoviesEvent, WatchlistMoviesState> {
  GetWatchlistMovies getWatchlistMovies;

  WatchlistMoviesBloc({required this.getWatchlistMovies})
    : super(WatchlistMoviesInitial()) {
    on<OnGetWatchlistMovies>(_onGetWatchlistMovie);
  }

  FutureOr<void> _onGetWatchlistMovie(
    OnGetWatchlistMovies event,
    Emitter<WatchlistMoviesState> emit,
  ) async {
    emit(WatchlistMoviesLoading());
    final result = await getWatchlistMovies.execute();
    result.fold(
      (failure) {
        emit(WatchlistMoviesError(failure.message));
      },
      (result) {
        emit(WatchlistMoviesLoaded(result));
      },
    );
  }
}
