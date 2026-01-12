import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:ditonton/features/movie/domain/entities/movie.dart';
import 'package:ditonton/features/movie/domain/usecases/get_now_playing_movies.dart';
import 'package:equatable/equatable.dart';

part 'now_playing_event.dart';
part 'now_playing_state.dart';

class NowPlayingBloc extends Bloc<NowPlayingEvent, NowPlayingState> {
  GetNowPlayingMovies getNowPlayingMovies;

  NowPlayingBloc({required this.getNowPlayingMovies})
    : super(NowPlayingInitial()) {
    on<OnGetNowPlayingMovies>(_onGetNowPlaying);
  }

  FutureOr<void> _onGetNowPlaying(
    OnGetNowPlayingMovies event,
    Emitter<NowPlayingState> emit,
  ) async {
    emit(NowPlayingLoading());
    final result = await getNowPlayingMovies.execute();
    result.fold(
      (failure) => emit(NowPlayingError(failure.message)),
      (movies) => emit(NowPlayingLoaded(movies)),
    );
  }
}
