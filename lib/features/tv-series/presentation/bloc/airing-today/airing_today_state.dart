part of 'airing_today_bloc.dart';

sealed class AiringTodayState extends Equatable {
  const AiringTodayState();

  @override
  List<Object> get props => [];
}

final class AiringTodayInitial extends AiringTodayState {}

class AiringTodayLoading extends AiringTodayState {}

class AiringTodayLoaded extends AiringTodayState {
  final List<TvSeries> tvSeriesList;

  const AiringTodayLoaded(this.tvSeriesList);

  @override
  List<Object> get props => [tvSeriesList];
}

class AiringTodayError extends AiringTodayState {
  final String message;

  const AiringTodayError(this.message);

  @override
  List<Object> get props => [message];
}
