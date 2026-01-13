import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:ditonton/features/tv-series/domain/entities/tv_series.dart';
import 'package:ditonton/features/tv-series/domain/usecases/get_airing_today_tv_series.dart';
import 'package:equatable/equatable.dart';

part 'airing_today_event.dart';
part 'airing_today_state.dart';

class AiringTodayBloc extends Bloc<AiringTodayEvent, AiringTodayState> {
  final GetAiringTodayTvSeries getAiringTodayTvSeries;

  AiringTodayBloc({required this.getAiringTodayTvSeries})
    : super(AiringTodayInitial()) {
    on<OnGetAiringTodayTvSeries>(_onGetAiringTodayTvSeries);
  }

  FutureOr<void> _onGetAiringTodayTvSeries(
    OnGetAiringTodayTvSeries event,
    Emitter<AiringTodayState> emit,
  ) async {
    emit(AiringTodayLoading());
    final result = await getAiringTodayTvSeries.execute();
    result.fold(
      (failure) => emit(AiringTodayError(failure.message)),
      (tvSeriesList) => emit(AiringTodayLoaded(tvSeriesList)),
    );
  }
}
