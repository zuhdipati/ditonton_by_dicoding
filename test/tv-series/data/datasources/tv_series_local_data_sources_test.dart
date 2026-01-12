import 'package:ditonton/common/exception.dart';
import 'package:ditonton/features/tv-series/data/datasources/tv_series_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/tv_series_test_helper.mocks.dart';

void main() {
  late TvSeriesLocalDataSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = TvSeriesLocalDataSourceImpl(
      databaseHelper: mockDatabaseHelper,
    );
  });

  group('save watchlist', () {
    test("should return success when insert to database is success", () async {
      when(
        mockDatabaseHelper.insertTvSeriesWatchlist(testTvSeriesTable),
      ).thenAnswer((_) async => 1);

      final result = await dataSource.insertWatchlist(testTvSeriesTable);

      expect(result, 'Added to Watchlist');
    });

    test(
      'should throw DatabaseException when insert to database is failed',
      () async {
        when(
          mockDatabaseHelper.insertTvSeriesWatchlist(testTvSeriesTable),
        ).thenThrow(Exception());

        final call = dataSource.insertWatchlist(testTvSeriesTable);

        expect(() => call, throwsA(isA<DatabaseException>()));
      },
    );
  });

  group('remove watchlist', () {
    test(
      'should return success message when remove from database is success',
      () async {
        when(
          mockDatabaseHelper.removeTvSeriesWatchlist(testTvSeriesTable),
        ).thenAnswer((_) async => 1);

        final result = await dataSource.removeWatchlist(testTvSeriesTable);

        expect(result, 'Removed from Watchlist');
      },
    );

    test(
      'should throw DatabaseException when remove from database is failed',
      () async {
        when(
          mockDatabaseHelper.removeTvSeriesWatchlist(testTvSeriesTable),
        ).thenThrow(Exception());

        final call = dataSource.removeWatchlist(testTvSeriesTable);

        expect(() => call, throwsA(isA<DatabaseException>()));
      },
    );
  });

  group("get tv series by Id", () {
    test('should return tv series from database', () async {
      when(
        mockDatabaseHelper.getTvSeriesById(1),
      ).thenAnswer((_) async => testTvSeriesMap);

      final result = await dataSource.getTvSeriesById(1);

      expect(result, testTvSeriesTable);
    });
  });

  group('get watchlist tv series', () {
    test('should return list of tv series from database', () async {
      when(
        mockDatabaseHelper.getWatchlistTvSeries(),
      ).thenAnswer((_) async => [testTvSeriesMap]);

      final result = await dataSource.getWatchlistTvSeries();

      expect(result, [testTvSeriesTable]);
    });
  });
}
