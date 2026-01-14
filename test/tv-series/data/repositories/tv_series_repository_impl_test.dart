import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/features/tv-series/data/repositories/tv_series_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/tv_series_test_helper.mocks.dart';

void main() {
  late TvSeriesRepositoryImpl repository;
  late MockTvSeriesRemoteDataSource mockRemoteDataSource;
  late MockTvSeriesLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockTvSeriesRemoteDataSource();
    mockLocalDataSource = MockTvSeriesLocalDataSource();
    repository = TvSeriesRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  group('airing today tv series', () {
    test(
      'should return remote data when the call to remote data source is successful',
      () async {
        when(
          mockRemoteDataSource.getAiringTodayTvSeries(),
        ).thenAnswer((_) async => testTvSeriesModelList);

        final result = await repository.getAiringTodayTvSeries();

        verify(mockRemoteDataSource.getAiringTodayTvSeries());

        final resultList = result.getOrElse(() => []);
        expect(resultList, testTvSeriesList);
      },
    );

    test(
      'should return server failure when the call to remote data source is unsuccessful',
      () async {
        when(
          mockRemoteDataSource.getAiringTodayTvSeries(),
        ).thenThrow(ServerException());

        final result = await repository.getAiringTodayTvSeries();

        verify(mockRemoteDataSource.getAiringTodayTvSeries());
        expect(result, Left(ServerFailure('')));
      },
    );

    test(
      'should return connection failure when the device is not connected to the internet',
      () async {
        when(
          mockRemoteDataSource.getAiringTodayTvSeries(),
        ).thenThrow(SocketException('Failed to connect to the network'));

        final result = await repository.getAiringTodayTvSeries();

        verify(mockRemoteDataSource.getAiringTodayTvSeries());
        expect(
          result,
          Left(ConnectionFailure('Failed to connect to the network')),
        );
      },
    );
  });

  group('popular tv series', () {
    test(
      "should return remote data when the call to remote data source is successful",
      () async {
        when(
          mockRemoteDataSource.getPopularTvSeries(),
        ).thenAnswer((_) async => testTvSeriesModelList);

        final result = await repository.getPopularTvSeries();

        verify(mockRemoteDataSource.getPopularTvSeries());

        final resultList = result.getOrElse(() => []);
        expect(resultList, testTvSeriesList);
      },
    );

    test(
      "should return server failure when the call is unsuccessful",
      () async {
        when(
          mockRemoteDataSource.getPopularTvSeries(),
        ).thenThrow(ServerException());

        final result = await repository.getPopularTvSeries();

        verify(mockRemoteDataSource.getPopularTvSeries());

        expect(result, Left(ServerFailure('')));
      },
    );

    test(
      'should return connection failure when the device is not connected to the internet',
      () async {
        when(
          mockRemoteDataSource.getPopularTvSeries(),
        ).thenThrow(SocketException('Failed to connect to the network'));

        final result = await repository.getPopularTvSeries();

        verify(mockRemoteDataSource.getPopularTvSeries());
        expect(
          result,
          Left(ConnectionFailure('Failed to connect to the network')),
        );
      },
    );
  });

  group('top rated tv series', () {
    test(
      "should return remote data when the call to remote data source is successful",
      () async {
        when(
          mockRemoteDataSource.getTopRatedTvSeries(),
        ).thenAnswer((_) async => testTvSeriesModelList);

        final result = await repository.getTopRatedTvSeries();

        verify(mockRemoteDataSource.getTopRatedTvSeries());

        final resultList = result.getOrElse(() => []);
        expect(resultList, testTvSeriesList);
      },
    );

    test(
      "should return server failure when the call is unsuccessful",
      () async {
        when(
          mockRemoteDataSource.getTopRatedTvSeries(),
        ).thenThrow(ServerException());

        final result = await repository.getTopRatedTvSeries();

        verify(mockRemoteDataSource.getTopRatedTvSeries());

        expect(result, Left(ServerFailure('')));
      },
    );

    test(
      'should return connection failure when the device is not connected to the internet',
      () async {
        when(
          mockRemoteDataSource.getTopRatedTvSeries(),
        ).thenThrow(SocketException('Failed to connect to the network'));

        final result = await repository.getTopRatedTvSeries();

        verify(mockRemoteDataSource.getTopRatedTvSeries());
        expect(
          result,
          Left(ConnectionFailure('Failed to connect to the network')),
        );
      },
    );
  });

  group('get tv series detail', () {
    final tId = 1;

    test(
      'should return tv series detail when call to remote data source is successful',
      () async {
        when(
          mockRemoteDataSource.getTvSeriesDetail(tId),
        ).thenAnswer((_) async => testTvSeriesDetailModel);

        final result = await repository.getTvSeriesDetail(tId);

        verify(mockRemoteDataSource.getTvSeriesDetail(tId));
        expect(result, equals(Right(testTvSeriesDetail)));
      },
    );

    test(
      'should return server failure when call to remote data source is unsuccessful',
      () async {
        when(
          mockRemoteDataSource.getTvSeriesDetail(tId),
        ).thenThrow(ServerException());

        final result = await repository.getTvSeriesDetail(tId);

        verify(mockRemoteDataSource.getTvSeriesDetail(tId));
        expect(result, Left(ServerFailure('')));
      },
    );

    test(
      'should return connection failure when device is not connected to the internet',
      () async {
        when(
          mockRemoteDataSource.getTvSeriesDetail(tId),
        ).thenThrow(SocketException('Failed to connect to the network'));

        final result = await repository.getTvSeriesDetail(tId);

        verify(mockRemoteDataSource.getTvSeriesDetail(tId));
        expect(
          result,
          Left(ConnectionFailure('Failed to connect to the network')),
        );
      },
    );
  });

  group('get tv series recommendations', () {
    final tId = 1;

    test(
      'should return tv series recommendations when call to remote data source is successful',
      () async {
        when(
          mockRemoteDataSource.getTvSeriesRecommendations(tId),
        ).thenAnswer((_) async => testTvSeriesModelList);

        final result = await repository.getTvSeriesRecommendations(tId);

        verify(mockRemoteDataSource.getTvSeriesRecommendations(tId));
        final resultList = result.getOrElse(() => []);
        expect(resultList, testTvSeriesList);
      },
    );

    test(
      'should return server failure when call to remote data source is unsuccessful',
      () async {
        when(
          mockRemoteDataSource.getTvSeriesRecommendations(tId),
        ).thenThrow(ServerException());

        final result = await repository.getTvSeriesRecommendations(tId);

        verify(mockRemoteDataSource.getTvSeriesRecommendations(tId));
        expect(result, Left(ServerFailure('')));
      },
    );

    test(
      'should return connection failure when device is not connected to the internet',
      () async {
        when(
          mockRemoteDataSource.getTvSeriesRecommendations(tId),
        ).thenThrow(SocketException('Failed to connect to the network'));

        final result = await repository.getTvSeriesRecommendations(tId);

        verify(mockRemoteDataSource.getTvSeriesRecommendations(tId));
        expect(
          result,
          Left(ConnectionFailure('Failed to connect to the network')),
        );
      },
    );
  });

  group('search tv series', () {
    final tQuery = 'game of thrones';

    test(
      'should return tv series list when call to remote data source is successful',
      () async {
        when(
          mockRemoteDataSource.searchTvSeries(tQuery),
        ).thenAnswer((_) async => testTvSeriesModelList);

        final result = await repository.searchTvSeries(tQuery);

        verify(mockRemoteDataSource.searchTvSeries(tQuery));
        final resultList = result.getOrElse(() => []);
        expect(resultList, testTvSeriesList);
      },
    );

    test(
      'should return server failure when call to remote data source is unsuccessful',
      () async {
        when(
          mockRemoteDataSource.searchTvSeries(tQuery),
        ).thenThrow(ServerException());

        final result = await repository.searchTvSeries(tQuery);

        verify(mockRemoteDataSource.searchTvSeries(tQuery));
        expect(result, Left(ServerFailure('')));
      },
    );

    test(
      'should return connection failure when device is not connected to the internet',
      () async {
        when(
          mockRemoteDataSource.searchTvSeries(tQuery),
        ).thenThrow(SocketException('Failed to connect to the network'));

        final result = await repository.searchTvSeries(tQuery);

        verify(mockRemoteDataSource.searchTvSeries(tQuery));
        expect(
          result,
          Left(ConnectionFailure('Failed to connect to the network')),
        );
      },
    );
  });

  group('get watchlist tv series', () {
    test(
      'should return local data from the database when call to database is successful',
      () async {
        when(
          mockLocalDataSource.getWatchlistTvSeries(),
        ).thenAnswer((_) async => [testTvSeriesTable]);

        final result = await repository.getWatchlistTvSeries();

        verify(mockLocalDataSource.getWatchlistTvSeries());
        final resultList = result.getOrElse(() => []);
        expect(resultList, [testWatchlistTvSeries]);
      },
    );

    test(
      'should return database failure when call to database is unsuccessful',
      () async {
        when(
          mockLocalDataSource.getWatchlistTvSeries(),
        ).thenThrow(DatabaseException(''));

        final result = await repository.getWatchlistTvSeries();

        verify(mockLocalDataSource.getWatchlistTvSeries());
        expect(result, Left(DatabaseFailure('')));
      },
    );
  });

  group('save watchlist tv series', () {
    test(
      'should return success message when call to database is successful',
      () async {
        when(
          mockLocalDataSource.insertWatchlist(testTvSeriesTable),
        ).thenAnswer((_) async => 'Added to watchlist');

        final result = await repository.saveWatchlistTvSeries(
          testTvSeriesDetail,
        );

        verify(mockLocalDataSource.insertWatchlist(testTvSeriesTable));
        expect(result, Right('Added to watchlist'));
      },
    );

    test(
      'should return database failure when call to database is unsuccessful',
      () async {
        when(
          mockLocalDataSource.insertWatchlist(testTvSeriesTable),
        ).thenThrow(DatabaseException(''));

        final result = await repository.saveWatchlistTvSeries(
          testTvSeriesDetail,
        );

        verify(mockLocalDataSource.insertWatchlist(testTvSeriesTable));
        expect(result, Left(DatabaseFailure('')));
      },
    );
  });

  group('remove watchlist tv series', () {
    test(
      'should return success message when call to database is successful',
      () async {
        when(
          mockLocalDataSource.removeWatchlist(testTvSeriesTable),
        ).thenAnswer((_) async => 'Removed from watchlist');

        final result = await repository.removeWatchlistTvSeries(
          testTvSeriesDetail,
        );

        verify(mockLocalDataSource.removeWatchlist(testTvSeriesTable));
        expect(result, Right('Removed from watchlist'));
      },
    );

    test(
      'should return database failure when call to database is unsuccessful',
      () async {
        when(
          mockLocalDataSource.removeWatchlist(testTvSeriesTable),
        ).thenThrow(DatabaseException(''));

        final result = await repository.removeWatchlistTvSeries(
          testTvSeriesDetail,
        );

        verify(mockLocalDataSource.removeWatchlist(testTvSeriesTable));
        expect(result, Left(DatabaseFailure('')));
      },
    );
  });

  group('get watchlist tv series status', () {
    test('should return watch status whether data is found', () async {
      final tId = 1;

      when(
        mockLocalDataSource.getTvSeriesById(tId),
      ).thenAnswer((_) async => null);

      final result = await repository.isAddedToWatchlistTvSeries(tId);
      expect(result, Right(false));
    });
  });

  group("get season episodes", () {
    final tId = 1;
    final tSeasonNumber = 3;
    test(
      "should return remote data when the call to remote data source is successful",
      () async {
        when(
          mockRemoteDataSource.getSeasonEpisodes(tId, tSeasonNumber),
        ).thenAnswer((_) async => testTvSeriesEpisodeModelList);

        final result = await repository.getSeasonEpisodes(tId, tSeasonNumber);
        verify(mockRemoteDataSource.getSeasonEpisodes(tId, tSeasonNumber));

        final resultList = result.getOrElse(() => []);
        expect(resultList, testTvSeriesEpisodeList);
      },
    );

    test(
      "should return server failure when the call to remote data source is unsuccessful",
      () async {
        when(
          mockRemoteDataSource.getSeasonEpisodes(tId, tSeasonNumber),
        ).thenThrow(ServerException());

        final result = await repository.getSeasonEpisodes(tId, tSeasonNumber);
        verify(mockRemoteDataSource.getSeasonEpisodes(tId, tSeasonNumber));
        expect(result, Left(ServerFailure('')));
      },
    );

    test(
      "should return connection failure when device is not connected to the internet",
      () async {
        when(
          mockRemoteDataSource.getSeasonEpisodes(tId, tSeasonNumber),
        ).thenThrow(SocketException('Failed to connect to the network'));

        final result = await repository.getSeasonEpisodes(tId, tSeasonNumber);
        verify(mockRemoteDataSource.getSeasonEpisodes(tId, tSeasonNumber));
        expect(
          result,
          Left(ConnectionFailure('Failed to connect to the network')),
        );
      },
    );
  });
}
