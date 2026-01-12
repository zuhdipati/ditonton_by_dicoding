part of 'movie_detail_bloc.dart';

class MovieDetailInitial extends MovieDetailState {}

class MovieDetailState extends Equatable {
  final MovieDetail? movieDetail;
  final RequestState movieDetailState;
  final List<Movie> movieRecommendations;
  final RequestState movieRecommendationState;
  final bool isAddedToWatchlist;
  final String watchlistMessage;
  final String message;

  const MovieDetailState({
    this.movieDetail,
    this.movieDetailState = RequestState.Empty,
    this.movieRecommendations = const [],
    this.movieRecommendationState = RequestState.Empty,
    this.isAddedToWatchlist = false,
    this.watchlistMessage = '',
    this.message = '',
  });

  MovieDetailState copyWith({
    MovieDetail? movieDetail,
    RequestState? movieDetailState,
    List<Movie>? movieRecommendations,
    RequestState? movieRecommendationState,
    bool? isAddedToWatchlist,
    String? watchlistMessage,
    String? message,
  }) {
    return MovieDetailState(
      movieDetail: movieDetail ?? this.movieDetail,
      movieDetailState: movieDetailState ?? this.movieDetailState,
      movieRecommendations: movieRecommendations ?? this.movieRecommendations,
      movieRecommendationState:
          movieRecommendationState ?? this.movieRecommendationState,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
    movieDetail,
    movieDetailState,
    movieRecommendations,
    movieRecommendationState,
    isAddedToWatchlist,
    watchlistMessage,
    message,
  ];
}
