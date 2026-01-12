import 'package:dartz/dartz.dart';
import 'package:ditonton/features/tv-series/domain/usecases/save_watchlist_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/tv_series_test_helper.mocks.dart';

void main() {
  late SaveWatchlistTvSeries usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = SaveWatchlistTvSeries(mockTvSeriesRepository);
  });

  test('should save watchlist tv series to repository', () async {
    when(mockTvSeriesRepository.saveWatchlistTvSeries(testTvSeriesDetail))
        .thenAnswer((realInvocation) async => Right('Added to watchlist'));

    final result = await usecase.execute(testTvSeriesDetail);

    expect(result, Right('Added to watchlist'));
  });
}