import 'package:dartz/dartz.dart';
import 'package:ditonton/features/tv-series/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/tv_series_test_helper.mocks.dart';

void main() {
  late RemoveWatchlistTvSeries usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = RemoveWatchlistTvSeries(mockTvSeriesRepository);
  });

  test("should remove watchlist tv series from repository", () async {
    when(mockTvSeriesRepository.removeWatchlistTvSeries(testTvSeriesDetail))
        .thenAnswer((realInvocation) async => Right('Removed from watchlist'));

    final result = await usecase.execute(testTvSeriesDetail);

    expect(result, Right('Removed from watchlist'));
  });
}
