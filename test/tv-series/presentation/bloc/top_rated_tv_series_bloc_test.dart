import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/features/tv-series/domain/usecases/get_top_rated_tv_series.dart';
import 'package:ditonton/features/tv-series/presentation/bloc/top-rated-tv-series/top_rated_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'top_rated_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTvSeries])
void main() {
  late TopRatedTvSeriesBloc topRatedTvSeriesBloc;
  late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;

  setUp(() {
    mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
    topRatedTvSeriesBloc = TopRatedTvSeriesBloc(
      getTopRatedTvSeries: mockGetTopRatedTvSeries,
    );
  });

  group('Top Rated TV Series Bloc', () {
    test('initial state should be TopRatedTvSeriesInitial', () {
      expect(topRatedTvSeriesBloc.state, TopRatedTvSeriesInitial());
    });

    blocTest<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
      'emits [TopRatedTvSeriesLoading, TopRatedTvSeriesLoaded] when OnGetTopRatedTvSeries is added',
      build: () {
        when(
          mockGetTopRatedTvSeries.execute(),
        ).thenAnswer((_) async => Right(testTvSeriesList));
        return topRatedTvSeriesBloc;
      },
      act: (bloc) => bloc.add(OnGetTopRatedTvSeries()),
      expect: () => <TopRatedTvSeriesState>[
        TopRatedTvSeriesLoading(),
        TopRatedTvSeriesLoaded(testTvSeriesList),
      ],
      verify: (bloc) => mockGetTopRatedTvSeries.execute(),
    );

    blocTest<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
      'emits [TopRatedTvSeriesLoading, TopRatedTvSeriesError] when OnGetTopRatedTvSeries fails',
      build: () {
        when(
          mockGetTopRatedTvSeries.execute(),
        ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return topRatedTvSeriesBloc;
      },
      act: (bloc) => bloc.add(OnGetTopRatedTvSeries()),
      expect: () => <TopRatedTvSeriesState>[
        TopRatedTvSeriesLoading(),
        TopRatedTvSeriesError('Server Failure'),
      ],
      verify: (bloc) => mockGetTopRatedTvSeries.execute(),
    );
  });
}
