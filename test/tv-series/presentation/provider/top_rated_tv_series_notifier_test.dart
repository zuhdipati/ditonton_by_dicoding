import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/tv-series/domain/usecases/get_top_rated_tv_series.dart';
import 'package:ditonton/features/tv-series/presentation/bloc/top_rated_tv_series_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'top_rated_tv_series_notifier_test.mocks.dart';

@GenerateMocks([GetTopRatedTvSeries])
void main() {
  late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;
  late TopRatedTvSeriesNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
    notifier =
        TopRatedTvSeriesNotifier(getTopRatedTvSeries: mockGetTopRatedTvSeries)
          ..addListener(() {
            listenerCallCount++;
          });
  });

  test('should change state to loading when usecase is called', () async {

    when(mockGetTopRatedTvSeries.execute())
        .thenAnswer((_) async => Right(testTvSeriesList));

    notifier.fetchTopRatedTvSeries();

    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change tv series data when data is gotten successfully',
      () async {

    when(mockGetTopRatedTvSeries.execute())
        .thenAnswer((_) async => Right(testTvSeriesList));

    await notifier.fetchTopRatedTvSeries();

    expect(notifier.state, RequestState.Loaded);
    expect(notifier.tvSeries, testTvSeriesList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {

    when(mockGetTopRatedTvSeries.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

    await notifier.fetchTopRatedTvSeries();

    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
