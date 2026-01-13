part of 'search_tv_series_bloc.dart';

sealed class SearchTvSeriesEvent extends Equatable {
  const SearchTvSeriesEvent();

  @override
  List<Object> get props => [];
}

class OnSearchTvSeries extends SearchTvSeriesEvent {
  final String query;

  const OnSearchTvSeries(this.query);

  @override
  List<Object> get props => [query];
}
