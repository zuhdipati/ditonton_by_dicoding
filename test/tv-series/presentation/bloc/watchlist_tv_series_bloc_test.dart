import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/features/tv-series/domain/usecases/get_watchlist_tv_series.dart';
import 'package:ditonton/features/tv-series/presentation/bloc/watchlist-tv-series/watchlist_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistTvSeries])
void main() {
  late WatchlistTvSeriesBloc watchlistTvSeriesBloc;
  late MockGetWatchlistTvSeries mockGetWatchlistTvSeries;

  setUp(() {
    mockGetWatchlistTvSeries = MockGetWatchlistTvSeries();
    watchlistTvSeriesBloc = WatchlistTvSeriesBloc(
      getWatchlistTvSeries: mockGetWatchlistTvSeries,
    );
  });

  group('Watchlist TV Series Bloc', () {
    test('initial state should be WatchlistTvSeriesInitial', () {
      expect(watchlistTvSeriesBloc.state, WatchlistTvSeriesInitial());
    });

    blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
      'emits [WatchlistTvSeriesLoading, WatchlistTvSeriesLoaded] when OnGetWatchlistTvSeries is added',
      build: () {
        when(
          mockGetWatchlistTvSeries.execute(),
        ).thenAnswer((_) async => Right(testTvSeriesList));
        return watchlistTvSeriesBloc;
      },
      act: (bloc) => bloc.add(OnGetWatchlistTvSeries()),
      expect: () => <WatchlistTvSeriesState>[
        WatchlistTvSeriesLoading(),
        WatchlistTvSeriesLoaded(testTvSeriesList),
      ],
      verify: (bloc) => mockGetWatchlistTvSeries.execute(),
    );

    blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
      'emits [WatchlistTvSeriesLoading, WatchlistTvSeriesError] when OnGetWatchlistTvSeries fails',
      build: () {
        when(
          mockGetWatchlistTvSeries.execute(),
        ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return watchlistTvSeriesBloc;
      },
      act: (bloc) => bloc.add(OnGetWatchlistTvSeries()),
      expect: () => <WatchlistTvSeriesState>[
        WatchlistTvSeriesLoading(),
        WatchlistTvSeriesError('Server Failure'),
      ],
      verify: (bloc) => mockGetWatchlistTvSeries.execute(),
    );
  });
}
