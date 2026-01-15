part of 'search_movies_bloc.dart';

sealed class SearchMoviesEvent extends Equatable {
  const SearchMoviesEvent();
}

class OnSearchMovies extends SearchMoviesEvent {
  final String query;

  const OnSearchMovies(this.query);

  @override
  List<Object> get props => [query];
}
