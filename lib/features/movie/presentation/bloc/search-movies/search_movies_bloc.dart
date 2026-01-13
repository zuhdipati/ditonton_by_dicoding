import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:ditonton/features/movie/domain/entities/movie.dart';
import 'package:ditonton/features/movie/domain/usecases/search_movies.dart';
import 'package:equatable/equatable.dart';

part 'search_movies_event.dart';
part 'search_movies_state.dart';

class SearchMoviesBloc extends Bloc<SearchMoviesEvent, SearchMoviesState> {
  SearchMovies searchMovies;

  SearchMoviesBloc({required this.searchMovies})
    : super(SearchMoviesInitial()) {
    on<OnSearchMovies>(_onSearchMovies);
  }

  FutureOr<void> _onSearchMovies(
    OnSearchMovies event,
    Emitter<SearchMoviesState> emit,
  ) async {
    emit(SearchMoviesLoading());
    final result = await searchMovies.execute(event.query);
    result.fold(
      (failure) => emit(SearchMoviesError(failure.message)),
      (movies) => emit(SearchMoviesLoaded(movies)),
    );
  }
}
