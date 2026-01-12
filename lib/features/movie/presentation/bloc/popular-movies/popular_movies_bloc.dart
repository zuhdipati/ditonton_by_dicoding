import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:ditonton/features/movie/domain/entities/movie.dart';
import 'package:ditonton/features/movie/domain/usecases/get_popular_movies.dart';
import 'package:equatable/equatable.dart';

part 'popular_movies_event.dart';
part 'popular_movies_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  GetPopularMovies getPopularMovies;

  PopularMoviesBloc({required this.getPopularMovies})
    : super(PopularMoviesInitial()) {
    on<OnGetPopularMovies>(_onGetPupularMovies);
  }

  FutureOr<void> _onGetPupularMovies(
    OnGetPopularMovies event,
    Emitter<PopularMoviesState> emit,
  ) async {
    emit(PopularMoviesLoading());
    final result = await getPopularMovies.execute();
    result.fold(
      (failure) => emit(PopularMoviesError(failure.message)),
      (movies) => emit(PopularMoviesLoaded(movies)),
    );
  }
}
