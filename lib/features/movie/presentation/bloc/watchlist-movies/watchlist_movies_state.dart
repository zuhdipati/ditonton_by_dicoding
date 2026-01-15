part of 'watchlist_movies_bloc.dart';

sealed class WatchlistMoviesState extends Equatable {
  const WatchlistMoviesState();

  @override
  List<Object> get props => [];
}

final class WatchlistMoviesInitial extends WatchlistMoviesState {}

class WatchlistMoviesLoading extends WatchlistMoviesState {}

class WatchlistMoviesError extends WatchlistMoviesState {
  final String message;

  const WatchlistMoviesError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistMoviesLoaded extends WatchlistMoviesState {
  final List<Movie> result;

  const WatchlistMoviesLoaded(this.result);

  @override
  List<Object> get props => [result];
}
