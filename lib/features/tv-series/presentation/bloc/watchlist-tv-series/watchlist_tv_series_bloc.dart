import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:ditonton/features/tv-series/domain/entities/tv_series.dart';
import 'package:ditonton/features/tv-series/domain/usecases/get_watchlist_tv_series.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_tv_series_event.dart';
part 'watchlist_tv_series_state.dart';

class WatchlistTvSeriesBloc
    extends Bloc<WatchlistTvSeriesEvent, WatchlistTvSeriesState> {
  final GetWatchlistTvSeries getWatchlistTvSeries;

  WatchlistTvSeriesBloc({required this.getWatchlistTvSeries})
    : super(WatchlistTvSeriesInitial()) {
    on<OnGetWatchlistTvSeries>(_onGetWatchlistTvSeries);
  }

  FutureOr<void> _onGetWatchlistTvSeries(
    OnGetWatchlistTvSeries event,
    Emitter<WatchlistTvSeriesState> emit,
  ) async {
    emit(WatchlistTvSeriesLoading());
    final result = await getWatchlistTvSeries.execute();
    result.fold(
      (failure) => emit(WatchlistTvSeriesError(failure.message)),
      (tvSeriesList) => emit(WatchlistTvSeriesLoaded(tvSeriesList)),
    );
  }
}
