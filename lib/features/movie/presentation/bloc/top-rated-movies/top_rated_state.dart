part of 'top_rated_bloc.dart';

sealed class TopRatedState extends Equatable {
  const TopRatedState();

  @override
  List<Object> get props => [];
}

final class TopRatedInitial extends TopRatedState {}

class TopRatedLoading extends TopRatedState {}

class TopRatedLoaded extends TopRatedState {
  final List<Movie> movies;

  const TopRatedLoaded(this.movies);

  @override
  List<Object> get props => [movies];
}

class TopRatedError extends TopRatedState {
  final String message;

  const TopRatedError(this.message);

  @override
  List<Object> get props => [message];
}
