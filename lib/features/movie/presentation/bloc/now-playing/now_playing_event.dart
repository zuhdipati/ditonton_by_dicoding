part of 'now_playing_bloc.dart';

sealed class NowPlayingEvent {
  const NowPlayingEvent();
}

class OnGetNowPlayingMovies extends NowPlayingEvent {
  const OnGetNowPlayingMovies();
}
