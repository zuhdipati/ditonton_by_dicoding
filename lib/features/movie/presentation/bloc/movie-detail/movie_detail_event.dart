part of 'movie_detail_bloc.dart';

sealed class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object> get props => [];
}

class OnGetMovieDetail extends MovieDetailEvent {
  final int id;

  const OnGetMovieDetail(this.id);

  @override
  List<Object> get props => [id];
}

class OnGetMovieRecommendations extends MovieDetailEvent {
  final int id;

  const OnGetMovieRecommendations(this.id);

  @override
  List<Object> get props => [id];
}

class OnGetWatchlist extends MovieDetailEvent {
  final int id;

  const OnGetWatchlist(this.id);

  @override
  List<Object> get props => [id];
}

class OnSaveWatchlist extends MovieDetailEvent {
  final MovieDetail movie;

  const OnSaveWatchlist(this.movie);

  @override
  List<Object> get props => [movie];
}

class OnRemoveWatchlist extends MovieDetailEvent {
  final MovieDetail movie;

  const OnRemoveWatchlist(this.movie);

  @override
  List<Object> get props => [movie];
}
