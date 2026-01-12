part of 'now_playing_bloc.dart';

sealed class NowPlayingEvent extends Equatable {
  const NowPlayingEvent();

  @override
  List<Object> get props => [];
}

class OnGetNowPlayingMovies extends NowPlayingEvent {
  const OnGetNowPlayingMovies();

  @override
  List<Object> get props => [];
}
