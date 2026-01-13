part of 'airing_today_bloc.dart';

sealed class AiringTodayEvent extends Equatable {
  const AiringTodayEvent();

  @override
  List<Object> get props => [];
}

class OnGetAiringTodayTvSeries extends AiringTodayEvent {
  const OnGetAiringTodayTvSeries();

  @override
  List<Object> get props => [];
}
