import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/tv-series/domain/usecases/get_airing_today_tv_series.dart';
import 'package:ditonton/features/tv-series/domain/usecases/get_popular_tv_series.dart';
import 'package:ditonton/features/tv-series/domain/usecases/get_top_rated_tv_series.dart';
import 'package:ditonton/features/tv-series/presentation/bloc/tv_series_list_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_list_notifier_test.mocks.dart';

@GenerateMocks(
    [GetAiringTodayTvSeries, GetPopularTvSeries, GetTopRatedTvSeries])
void main() {
  late TvSeriesListNotifier provider;
  late MockGetAiringTodayTvSeries mockGetAiringTodayTvSeries;
  late MockGetPopularTvSeries mockGetPopularTvSeries;
  late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetAiringTodayTvSeries = MockGetAiringTodayTvSeries();
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
    provider = TvSeriesListNotifier(
      getAiringTodayTvSeries: mockGetAiringTodayTvSeries,
      getPopularTvSeries: mockGetPopularTvSeries,
      getTopRatedTvSeries: mockGetTopRatedTvSeries,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  group('airing today tv series', () {
    test('initialState should be Empty', () {
      expect(provider.airingTodayState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      when(mockGetAiringTodayTvSeries.execute())
          .thenAnswer((_) async => Right(testTvSeriesList));

      provider.fetchAiringTodayTvSeries();

      verify(mockGetAiringTodayTvSeries.execute());
    });

    test('should change state to Loading when usecase is called', () {
      when(mockGetAiringTodayTvSeries.execute())
          .thenAnswer((_) async => Right(testTvSeriesList));

      provider.fetchAiringTodayTvSeries();

      expect(provider.airingTodayState, RequestState.Loading);
    });

    test('should change tv series when data is gotten successfully', () async {
      when(mockGetAiringTodayTvSeries.execute())
          .thenAnswer((_) async => Right(testTvSeriesList));

      await provider.fetchAiringTodayTvSeries();

      expect(provider.airingTodayState, RequestState.Loaded);
      expect(provider.airingTodayTvSeries, testTvSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      when(mockGetAiringTodayTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      await provider.fetchAiringTodayTvSeries();

      expect(provider.airingTodayState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('popular tv series', () {
    test('should change state to loading when usecase is called', () async {
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Right(testTvSeriesList));

      provider.fetchPopularTvSeries();

      expect(provider.popularTvSeriesState, RequestState.Loading);
    });

    test('should change tv series data when data is gotten successfully',
        () async {
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Right(testTvSeriesList));

      await provider.fetchPopularTvSeries();

      expect(provider.popularTvSeriesState, RequestState.Loaded);
      expect(provider.popularTvSeries, testTvSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      await provider.fetchPopularTvSeries();
      
      expect(provider.popularTvSeriesState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('top rated tv series', () {
    test('should change state to loading when usecase is called', () async {
      when(mockGetTopRatedTvSeries.execute())
          .thenAnswer((_) async => Right(testTvSeriesList));

      provider.fetchTopRatedTvSeries();

      expect(provider.topRatedTvSeriesState, RequestState.Loading);
    });

    test('should change tv series data when data is gotten successfully',
        () async {
      when(mockGetTopRatedTvSeries.execute())
          .thenAnswer((_) async => Right(testTvSeriesList));

      await provider.fetchTopRatedTvSeries();

      expect(provider.topRatedTvSeriesState, RequestState.Loaded);
      expect(provider.topRatedTvSeries, testTvSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      when(mockGetTopRatedTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      await provider.fetchTopRatedTvSeries();

      expect(provider.topRatedTvSeriesState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
