import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:ditonton/features/tv-series/domain/entities/tv_series.dart';
import 'package:ditonton/features/tv-series/domain/usecases/search_tv_series.dart';
import 'package:equatable/equatable.dart';

part 'search_tv_series_event.dart';
part 'search_tv_series_state.dart';

class SearchTvSeriesBloc
    extends Bloc<SearchTvSeriesEvent, SearchTvSeriesState> {
  final SearchTvSeries searchTvSeries;

  SearchTvSeriesBloc({required this.searchTvSeries})
    : super(SearchTvSeriesInitial()) {
    on<OnSearchTvSeries>(_onSearchTvSeries);
  }

  FutureOr<void> _onSearchTvSeries(
    OnSearchTvSeries event,
    Emitter<SearchTvSeriesState> emit,
  ) async {
    emit(SearchTvSeriesLoading());
    final result = await searchTvSeries.execute(event.query);
    result.fold(
      (failure) => emit(SearchTvSeriesError(failure.message)),
      (tvSeriesList) => emit(SearchTvSeriesLoaded(tvSeriesList)),
    );
  }
}
