import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/tv-series/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton/features/tv-series/domain/usecases/get_tv_series_recomendations.dart';
import 'package:ditonton/features/tv-series/domain/usecases/get_watchlist_tv_series_status.dart';
import 'package:ditonton/features/tv-series/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:ditonton/features/tv-series/domain/usecases/save_watchlist_tv_series.dart';
import 'package:ditonton/features/tv-series/presentation/bloc/tv_series_detail_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetTvSeriesDetail,
  GetTvSeriesRecommendations,
  GetWatchlistTvSeriesStatus,
  SaveWatchlistTvSeries,
  RemoveWatchlistTvSeries
])
void main() {
  late TvSeriesDetailNotifier provider;
  late MockGetTvSeriesDetail mockGetTvSeriesDetail;
  late MockGetTvSeriesRecommendations mockGetTvSeriesRecommendations;
  late MockGetWatchlistTvSeriesStatus mockGetWatchlistTvSeriesStatus;
  late MockSaveWatchlistTvSeries mockSaveWatchlistTvSeries;
  late MockRemoveWatchlistTvSeries mockRemoveWatchlistTvSeries;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvSeriesDetail = MockGetTvSeriesDetail();
    mockGetTvSeriesRecommendations = MockGetTvSeriesRecommendations();
    mockGetWatchlistTvSeriesStatus = MockGetWatchlistTvSeriesStatus();
    mockSaveWatchlistTvSeries = MockSaveWatchlistTvSeries();
    mockRemoveWatchlistTvSeries = MockRemoveWatchlistTvSeries();
    provider = TvSeriesDetailNotifier(
      getTvSeriesDetail: mockGetTvSeriesDetail,
      getTvSeriesRecommendations: mockGetTvSeriesRecommendations,
      saveWatchlistTvSeries: mockSaveWatchlistTvSeries,
      removeWatchlistTvSeries: mockRemoveWatchlistTvSeries,
      getWatchlistTvSeriesStatus: mockGetWatchlistTvSeriesStatus,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tId = 1;

  void _arrangeUsecase() {
    when(mockGetTvSeriesDetail.execute(tId))
        .thenAnswer((_) async => Right(testTvSeriesDetail));
    when(mockGetTvSeriesRecommendations.execute(tId))
        .thenAnswer((_) async => Right(testTvSeriesList));
  }

  group("get tv series detail",
    () {
      test('should get data from usecase ', () async {
        _arrangeUsecase();

        await provider.fetchTvSeriesDetail(tId);

        verify(mockGetTvSeriesDetail.execute(tId));
        verify(mockGetTvSeriesRecommendations.execute(tId));
      });

      test("should change state to load when usecase is called", () {
        _arrangeUsecase();

        provider.fetchTvSeriesDetail(tId);

        expect(provider.tvSeriesState, RequestState.Loading);
        expect(listenerCallCount, 1);
      });

      test("should change tv series when data is gotten successfully",
          () async {
        _arrangeUsecase();

        await provider.fetchTvSeriesDetail(tId);

        expect(provider.tvSeriesState, RequestState.Loaded);
        expect(provider.tvSeries, testTvSeriesDetail);
        expect(listenerCallCount, 3);
      });

      test(
          "should change recommendation state when data is gotten successfully",
          () async {
        _arrangeUsecase();

        await provider.fetchTvSeriesDetail(tId);

        expect(provider.tvSeriesState, RequestState.Loaded);
        expect(provider.tvSeriesRecommendations, testTvSeriesList);
      });
    },
  );

  group("tv series recommendation", () {
      test("should get data from usecase", () async {
        _arrangeUsecase();

        await provider.fetchTvSeriesDetail(tId);

        verify(mockGetTvSeriesRecommendations.execute(tId));
        expect(provider.tvSeriesRecommendations, testTvSeriesList);
      });

      test(
          "should update recommendation state when data is gotten successfully",
          () async {
        _arrangeUsecase();

        await provider.fetchTvSeriesDetail(tId);

        expect(provider.recommendationState, RequestState.Loaded);
        expect(provider.tvSeriesRecommendations, testTvSeriesList);
      });

      test("should update error message when request in successful", () async {
        when(mockGetTvSeriesDetail.execute(tId))
            .thenAnswer((_) async => Right(testTvSeriesDetail));
        when(mockGetTvSeriesRecommendations.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Failed')));

        await provider.fetchTvSeriesDetail(tId);

        expect(provider.recommendationState, RequestState.Error);
        expect(provider.message, 'Failed');
      });
    },
  );

  group("watchlist tv series", () {
    test(
      "should get the watchlist status",
      () async {
        when(mockGetWatchlistTvSeriesStatus.execute(1))
            .thenAnswer((_) async => Right(true));

        await provider.loadWatchlistStatus(1);

        expect(provider.isAddedToWatchlist, true);
      },
    );

    test(
      "should execute save watchlist when function called",
      () async {
        when(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail))
            .thenAnswer((_) async => Right("Success"));
        when(mockGetWatchlistTvSeriesStatus.execute(testTvSeriesDetail.id))
            .thenAnswer((_) async => Right(true));

        await provider.addWatchlist(testTvSeriesDetail);

        verify(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail));
      },
    );

    test("should execute remove watchlist when called", () async {
      when(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail))
          .thenAnswer((_) async => Right("Success"));
      when(mockGetWatchlistTvSeriesStatus.execute(testTvSeriesDetail.id))
          .thenAnswer((_) async => Right(true));

      await provider.removeFromWatchlist(testTvSeriesDetail);

      verify(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail));
    });

    test("should update watchlist status when add watchlist success", () async {
      when(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail))
          .thenAnswer((_) async => Right("Added to Watchlist"));
      when(mockGetWatchlistTvSeriesStatus.execute(testTvSeriesDetail.id))
          .thenAnswer((_) async => Right(true));

      await provider.addWatchlist(testTvSeriesDetail);

      verify(mockGetWatchlistTvSeriesStatus.execute(testTvSeriesDetail.id));
      expect(provider.isAddedToWatchlist, true);
      expect(provider.watchlistMessage, 'Added to Watchlist');
      expect(listenerCallCount, 1);
    });

    test("should update watchlist message when add watchlist failed", () async {
      when(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail))
          .thenAnswer((_) async => Left(ServerFailure('Failed')));
      when(mockGetWatchlistTvSeriesStatus.execute(testTvSeriesDetail.id))
          .thenAnswer((_) async => Right(false));

      await provider.addWatchlist(testTvSeriesDetail);

      verify(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail));
      expect(provider.watchlistMessage, 'Failed');
      expect(listenerCallCount, 1);
    });
  });


  group("on error", () {
    test("should return error when unsuccessfull", () async {
      when(mockGetTvSeriesDetail.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      when(mockGetTvSeriesRecommendations.execute(tId))
          .thenAnswer((_) async => Right(testTvSeriesList));

      await provider.fetchTvSeriesDetail(tId);

      expect(provider.tvSeriesState, RequestState.Error);
      expect(provider.message, 'Server Failure');
    });
  });
}
