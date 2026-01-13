import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:ditonton/features/tv-series/domain/entities/tv_series.dart';
import 'package:ditonton/features/tv-series/domain/usecases/get_top_rated_tv_series.dart';
import 'package:equatable/equatable.dart';

part 'top_rated_tv_series_event.dart';
part 'top_rated_tv_series_state.dart';

class TopRatedTvSeriesBloc
    extends Bloc<TopRatedTvSeriesEvent, TopRatedTvSeriesState> {
  final GetTopRatedTvSeries getTopRatedTvSeries;

  TopRatedTvSeriesBloc({required this.getTopRatedTvSeries})
    : super(TopRatedTvSeriesInitial()) {
    on<OnGetTopRatedTvSeries>(_onGetTopRatedTvSeries);
  }

  FutureOr<void> _onGetTopRatedTvSeries(
    OnGetTopRatedTvSeries event,
    Emitter<TopRatedTvSeriesState> emit,
  ) async {
    emit(TopRatedTvSeriesLoading());
    final result = await getTopRatedTvSeries.execute();
    result.fold(
      (failure) => emit(TopRatedTvSeriesError(failure.message)),
      (tvSeriesList) => emit(TopRatedTvSeriesLoaded(tvSeriesList)),
    );
  }
}
