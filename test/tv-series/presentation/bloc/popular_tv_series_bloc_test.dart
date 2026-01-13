import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/features/tv-series/domain/usecases/get_popular_tv_series.dart';
import 'package:ditonton/features/tv-series/presentation/bloc/popular-tv-series/popular_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'popular_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTvSeries])
void main() {
  late PopularTvSeriesBloc popularTvSeriesBloc;
  late MockGetPopularTvSeries mockGetPopularTvSeries;

  setUp(() {
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    popularTvSeriesBloc = PopularTvSeriesBloc(
      getPopularTvSeries: mockGetPopularTvSeries,
    );
  });

  group('Popular TV Series Bloc', () {
    test('initial state should be PopularTvSeriesInitial', () {
      expect(popularTvSeriesBloc.state, PopularTvSeriesInitial());
    });

    blocTest<PopularTvSeriesBloc, PopularTvSeriesState>(
      'emits [PopularTvSeriesLoading, PopularTvSeriesLoaded] when OnGetPopularTvSeries is added',
      build: () {
        when(
          mockGetPopularTvSeries.execute(),
        ).thenAnswer((_) async => Right(testTvSeriesList));
        return popularTvSeriesBloc;
      },
      act: (bloc) => bloc.add(OnGetPopularTvSeries()),
      expect: () => <PopularTvSeriesState>[
        PopularTvSeriesLoading(),
        PopularTvSeriesLoaded(testTvSeriesList),
      ],
      verify: (bloc) => mockGetPopularTvSeries.execute(),
    );

    blocTest<PopularTvSeriesBloc, PopularTvSeriesState>(
      'emits [PopularTvSeriesLoading, PopularTvSeriesError] when OnGetPopularTvSeries fails',
      build: () {
        when(
          mockGetPopularTvSeries.execute(),
        ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return popularTvSeriesBloc;
      },
      act: (bloc) => bloc.add(OnGetPopularTvSeries()),
      expect: () => <PopularTvSeriesState>[
        PopularTvSeriesLoading(),
        PopularTvSeriesError('Server Failure'),
      ],
      verify: (bloc) => mockGetPopularTvSeries.execute(),
    );
  });
}
