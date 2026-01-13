part of 'airing_today_bloc.dart';

sealed class AiringTodayEvent {
  const AiringTodayEvent();
}

class OnGetAiringTodayTvSeries extends AiringTodayEvent {
  const OnGetAiringTodayTvSeries();
}
