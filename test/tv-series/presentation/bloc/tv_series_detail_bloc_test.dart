import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/tv-series/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton/features/tv-series/domain/usecases/get_tv_series_recomendations.dart';
import 'package:ditonton/features/tv-series/domain/usecases/get_tv_series_seasons.dart';
import 'package:ditonton/features/tv-series/domain/usecases/get_watchlist_tv_series_status.dart';
import 'package:ditonton/features/tv-series/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:ditonton/features/tv-series/domain/usecases/save_watchlist_tv_series.dart';
import 'package:ditonton/features/tv-series/presentation/bloc/tv-series-detail/tv_series_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvSeriesDetail,
  GetTvSeriesRecommendations,
  GetWatchlistTvSeriesStatus,
  SaveWatchlistTvSeries,
  RemoveWatchlistTvSeries,
  GetSeasonEpisodes,
])
void main() {
  late TvSeriesDetailBloc tvSeriesDetailBloc;
  late MockGetTvSeriesDetail mockGetTvSeriesDetail;
  late MockGetTvSeriesRecommendations mockGetTvSeriesRecommendations;
  late MockGetWatchlistTvSeriesStatus mockGetWatchlistTvSeriesStatus;
  late MockSaveWatchlistTvSeries mockSaveWatchlistTvSeries;
  late MockRemoveWatchlistTvSeries mockRemoveWatchlistTvSeries;
  late MockGetSeasonEpisodes mockGetSeasonEpisodes;

  setUp(() {
    mockGetTvSeriesDetail = MockGetTvSeriesDetail();
    mockGetTvSeriesRecommendations = MockGetTvSeriesRecommendations();
    mockGetWatchlistTvSeriesStatus = MockGetWatchlistTvSeriesStatus();
    mockSaveWatchlistTvSeries = MockSaveWatchlistTvSeries();
    mockRemoveWatchlistTvSeries = MockRemoveWatchlistTvSeries();
    mockGetSeasonEpisodes = MockGetSeasonEpisodes();
    tvSeriesDetailBloc = TvSeriesDetailBloc(
      getTvSeriesDetail: mockGetTvSeriesDetail,
      getTvSeriesRecommendations: mockGetTvSeriesRecommendations,
      getWatchlistTvSeriesStatus: mockGetWatchlistTvSeriesStatus,
      saveWatchlistTvSeries: mockSaveWatchlistTvSeries,
      removeWatchlistTvSeries: mockRemoveWatchlistTvSeries,
      getSeasonEpisodes: mockGetSeasonEpisodes,
    );
  });

  const tId = 202250;

  group('Get TV Series Detail', () {
    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'emits Loading and then Loaded when GetTvSeriesDetail is successful',
      build: () {
        when(
          mockGetTvSeriesDetail.execute(tId),
        ).thenAnswer((_) async => Right(testTvSeriesDetail));
        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(const OnGetTvSeriesDetail(tId)),
      expect: () => [
        const TvSeriesDetailState(tvSeriesDetailState: RequestState.Loading),
        TvSeriesDetailState(
          tvSeriesDetail: testTvSeriesDetail,
          tvSeriesDetailState: RequestState.Loaded,
        ),
      ],
      verify: (_) {
        verify(mockGetTvSeriesDetail.execute(tId));
      },
    );

    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'emits Loading and then Error when GetTvSeriesDetail fails',
      build: () {
        when(
          mockGetTvSeriesDetail.execute(tId),
        ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(const OnGetTvSeriesDetail(tId)),
      expect: () => [
        const TvSeriesDetailState(tvSeriesDetailState: RequestState.Loading),
        const TvSeriesDetailState(
          message: 'Server Failure',
          tvSeriesDetailState: RequestState.Error,
        ),
      ],
      verify: (_) {
        verify(mockGetTvSeriesDetail.execute(tId));
      },
    );
  });

  group('Get TV Series Recommendations', () {
    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'emits Loading and then Loaded when GetTvSeriesRecommendations is successful',
      build: () {
        when(
          mockGetTvSeriesRecommendations.execute(tId),
        ).thenAnswer((_) async => Right(testTvSeriesList));
        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(const OnGetTvSeriesRecommendations(tId)),
      expect: () => [
        const TvSeriesDetailState(
          tvSeriesRecommendationState: RequestState.Loading,
        ),
        TvSeriesDetailState(
          tvSeriesRecommendations: testTvSeriesList,
          tvSeriesRecommendationState: RequestState.Loaded,
        ),
      ],
      verify: (_) {
        verify(mockGetTvSeriesRecommendations.execute(tId));
      },
    );

    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'emits Loading and then Error when GetTvSeriesRecommendations fails',
      build: () {
        when(
          mockGetTvSeriesRecommendations.execute(tId),
        ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(const OnGetTvSeriesRecommendations(tId)),
      expect: () => [
        const TvSeriesDetailState(
          tvSeriesRecommendationState: RequestState.Loading,
        ),
        const TvSeriesDetailState(
          message: 'Server Failure',
          tvSeriesRecommendationState: RequestState.Error,
        ),
      ],
      verify: (_) {
        verify(mockGetTvSeriesRecommendations.execute(tId));
      },
    );
  });

  group('Watchlist', () {
    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'emits isAddedToWatchlist true when watchlist status is true',
      build: () {
        when(
          mockGetWatchlistTvSeriesStatus.execute(tId),
        ).thenAnswer((_) async => const Right(true));
        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(const OnGetWatchlistStatus(tId)),
      expect: () => [const TvSeriesDetailState(isAddedToWatchlist: true)],
      verify: (_) {
        verify(mockGetWatchlistTvSeriesStatus.execute(tId));
      },
    );

    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'emits isAddedToWatchlist false when watchlist status is false',
      build: () {
        when(
          mockGetWatchlistTvSeriesStatus.execute(tId),
        ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(const OnGetWatchlistStatus(tId)),
      expect: () => [const TvSeriesDetailState(isAddedToWatchlist: false)],
      verify: (_) {
        verify(mockGetWatchlistTvSeriesStatus.execute(tId));
      },
    );

    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'emits success message when SaveWatchlist is successful',
      build: () {
        when(
          mockSaveWatchlistTvSeries.execute(testTvSeriesDetail),
        ).thenAnswer((_) async => const Right('Added to Watchlist'));
        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(OnSaveWatchlist(testTvSeriesDetail)),
      expect: () => [
        const TvSeriesDetailState(
          watchlistMessage: 'Added to Watchlist',
          isAddedToWatchlist: true,
        ),
      ],
      verify: (_) {
        verify(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail));
      },
    );

    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'emits success message when RemoveWatchlist is successful',
      build: () {
        when(
          mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail),
        ).thenAnswer((_) async => const Right('Removed from Watchlist'));
        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(OnRemoveWatchlist(testTvSeriesDetail)),
      expect: () => [
        const TvSeriesDetailState(
          watchlistMessage: 'Removed from Watchlist',
          isAddedToWatchlist: false,
        ),
      ],
      verify: (_) {
        verify(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail));
      },
    );

    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'emits error message when SaveWatchlist fails',
      build: () {
        when(
          mockSaveWatchlistTvSeries.execute(testTvSeriesDetail),
        ).thenAnswer((_) async => Left(DatabaseFailure('Database Failure')));
        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(OnSaveWatchlist(testTvSeriesDetail)),
      expect: () => [
        const TvSeriesDetailState(watchlistMessage: 'Database Failure'),
      ],
      verify: (_) {
        verify(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail));
      },
    );

    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'emits error message when RemoveWatchlist fails',
      build: () {
        when(
          mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail),
        ).thenAnswer((_) async => Left(DatabaseFailure('Database Failure')));
        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(OnRemoveWatchlist(testTvSeriesDetail)),
      expect: () => [
        const TvSeriesDetailState(watchlistMessage: 'Database Failure'),
      ],
      verify: (_) {
        verify(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail));
      },
    );
  });
}
