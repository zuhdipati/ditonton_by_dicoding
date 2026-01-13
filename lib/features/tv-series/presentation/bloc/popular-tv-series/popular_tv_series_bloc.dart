import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:ditonton/features/tv-series/domain/entities/tv_series.dart';
import 'package:ditonton/features/tv-series/domain/usecases/get_popular_tv_series.dart';
import 'package:equatable/equatable.dart';

part 'popular_tv_series_event.dart';
part 'popular_tv_series_state.dart';

class PopularTvSeriesBloc
    extends Bloc<PopularTvSeriesEvent, PopularTvSeriesState> {
  final GetPopularTvSeries getPopularTvSeries;

  PopularTvSeriesBloc({required this.getPopularTvSeries})
    : super(PopularTvSeriesInitial()) {
    on<OnGetPopularTvSeries>(_onGetPopularTvSeries);
  }

  FutureOr<void> _onGetPopularTvSeries(
    OnGetPopularTvSeries event,
    Emitter<PopularTvSeriesState> emit,
  ) async {
    emit(PopularTvSeriesLoading());
    final result = await getPopularTvSeries.execute();
    result.fold(
      (failure) => emit(PopularTvSeriesError(failure.message)),
      (tvSeriesList) => emit(PopularTvSeriesLoaded(tvSeriesList)),
    );
  }
}
