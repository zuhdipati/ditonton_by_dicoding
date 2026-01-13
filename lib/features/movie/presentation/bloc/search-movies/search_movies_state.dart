part of 'search_movies_bloc.dart';

sealed class SearchMoviesState extends Equatable {
  const SearchMoviesState();

  @override
  List<Object> get props => [];
}

final class SearchMoviesInitial extends SearchMoviesState {}

class SearchMoviesLoading extends SearchMoviesState {}

class SearchMoviesError extends SearchMoviesState {
  final String message;

  const SearchMoviesError(this.message);

  @override
  List<Object> get props => [message];
}

class SearchMoviesLoaded extends SearchMoviesState {
  final List<Movie> result;

  const SearchMoviesLoaded(this.result);

  @override
  List<Object> get props => [result];
}
