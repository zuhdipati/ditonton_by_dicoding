import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/tv-series/domain/usecases/get_popular_tv_series.dart';
import 'package:ditonton/features/tv-series/presentation/bloc/popular_tv_series_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'popular_tv_series_notifier_test.mocks.dart';

@GenerateMocks([GetPopularTvSeries])
void main() {
  late MockGetPopularTvSeries mockGetPopularTvSeries;
  late PopularTvSeriesNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    notifier = PopularTvSeriesNotifier(mockGetPopularTvSeries)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  test('should change state to loading when usecase is called', () async {
    when(mockGetPopularTvSeries.execute())
        .thenAnswer((_) async => Right(testTvSeriesList));

    notifier.fetchPopularTvSeries();

    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change tv series data when data is gotten successfully',
      () async {

    when(mockGetPopularTvSeries.execute())
        .thenAnswer((_) async => Right(testTvSeriesList));

    await notifier.fetchPopularTvSeries();

    expect(notifier.state, RequestState.Loaded);
    expect(notifier.tvSeries, testTvSeriesList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {

    when(mockGetPopularTvSeries.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

    await notifier.fetchPopularTvSeries();

    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
