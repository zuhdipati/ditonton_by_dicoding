import 'package:ditonton/data/db/database_helper.dart';
import 'package:ditonton/features/tv-series/data/models/tv_series_table.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:ditonton/features/movie/data/models/movie_table.dart';

void main() {
  late DatabaseHelper databaseHelper;

  setUp(() async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;

    databaseHelper = DatabaseHelper();

    final db = await databaseHelper.database;
    await db?.delete('watchlist');
    await db?.delete('tv_series_watchlist');
  });

  final tMovieTable = MovieTable(
    id: 1,
    title: 'Title',
    posterPath: 'posterPath',
    overview: 'Overview',
  );

  final tTvSeriesTable = TvSeriesTable(
    id: 1,
    name: 'Name',
    posterPath: 'posterPath',
    overview: 'Overview',
  );

  group('DatabaseHelper Test', () {
    test('watchlist movie', () async {
      final id = await databaseHelper.insertMovieWatchlist(tMovieTable);

      expect(id, 1);

      final result = await databaseHelper.getMovieById(1);

      expect(result, isNotNull);
      expect(result!['title'], 'Title');

      final deleteResult = await databaseHelper.removeMovieWatchlist(
        tMovieTable,
      );
      expect(deleteResult, 1);

      final resultAfterDelete = await databaseHelper.getMovieById(1);
      expect(resultAfterDelete, isNull);

      final resultGetWatchlist = await databaseHelper.getWatchlistMovies();
      expect(resultGetWatchlist, []);
    });

    test('watchlist tv series', () async {
      final id = await databaseHelper.insertTvSeriesWatchlist(tTvSeriesTable);

      expect(id, 1);

      final result = await databaseHelper.getTvSeriesById(1);

      expect(result, isNotNull);
      expect(result!['name'], 'Name');

      final deleteResult = await databaseHelper.removeTvSeriesWatchlist(
        tTvSeriesTable,
      );
      expect(deleteResult, 1);

      final resultAfterDelete = await databaseHelper.getTvSeriesById(1);
      expect(resultAfterDelete, isNull);

      final resultGetWatchlist = await databaseHelper.getWatchlistTvSeries();
      expect(resultGetWatchlist, []);
    });
  });
}
