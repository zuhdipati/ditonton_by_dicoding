import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:ditonton/features/movie/domain/entities/movie.dart';
import 'package:ditonton/features/movie/domain/usecases/get_top_rated_movies.dart';
import 'package:equatable/equatable.dart';

part 'top_rated_event.dart';
part 'top_rated_state.dart';

class TopRatedBloc extends Bloc<TopRatedEvent, TopRatedState> {
  GetTopRatedMovies getTopRatedMovies;

  TopRatedBloc({required this.getTopRatedMovies}) : super(TopRatedInitial()) {
    on<TopRatedEvent>(_onGetTopRatedMovies);
  }

  FutureOr<void> _onGetTopRatedMovies(
    TopRatedEvent event,
    Emitter<TopRatedState> emit,
  ) async {
    emit(TopRatedLoading());
    final result = await getTopRatedMovies.execute();
    result.fold(
      (failure) => emit(TopRatedError(failure.message)),
      (movies) => emit(TopRatedLoaded(movies)),
    );
  }
  
}
