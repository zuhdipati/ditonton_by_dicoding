part of 'top_rated_bloc.dart';

sealed class TopRatedEvent {
  const TopRatedEvent();
}

class OnGetTopRatedMovies extends TopRatedEvent {}
