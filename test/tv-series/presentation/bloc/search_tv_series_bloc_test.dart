import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/features/tv-series/domain/usecases/search_tv_series.dart';
import 'package:ditonton/features/tv-series/presentation/bloc/search-tv-series/search_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'search_tv_series_bloc_test.mocks.dart';

@GenerateMocks([SearchTvSeries])
void main() {
  late SearchTvSeriesBloc searchTvSeriesBloc;
  late MockSearchTvSeries mockSearchTvSeries;

  setUp(() {
    mockSearchTvSeries = MockSearchTvSeries();
    searchTvSeriesBloc = SearchTvSeriesBloc(searchTvSeries: mockSearchTvSeries);
  });

  group('Search TV Series Bloc', () {
    test('initial state should be SearchTvSeriesInitial', () {
      expect(searchTvSeriesBloc.state, SearchTvSeriesInitial());
    });

    blocTest<SearchTvSeriesBloc, SearchTvSeriesState>(
      'emits [SearchTvSeriesLoading, SearchTvSeriesLoaded] when success',
      build: () {
        when(
          mockSearchTvSeries.execute('dirty linen'),
        ).thenAnswer((_) async => Right(testTvSeriesList));
        return searchTvSeriesBloc;
      },
      act: (bloc) => bloc.add(const OnSearchTvSeries('dirty linen')),
      expect: () => <SearchTvSeriesState>[
        SearchTvSeriesLoading(),
        SearchTvSeriesLoaded(testTvSeriesList),
      ],
      verify: (bloc) {
        verify(mockSearchTvSeries.execute('dirty linen'));
      },
    );

    blocTest<SearchTvSeriesBloc, SearchTvSeriesState>(
      'emits [SearchTvSeriesLoading, SearchTvSeriesError] when unsuccess',
      build: () {
        when(
          mockSearchTvSeries.execute('dirty linen'),
        ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return searchTvSeriesBloc;
      },
      act: (bloc) => bloc.add(const OnSearchTvSeries('dirty linen')),
      expect: () => <SearchTvSeriesState>[
        SearchTvSeriesLoading(),
        SearchTvSeriesError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockSearchTvSeries.execute('dirty linen'));
      },
    );
  });
}
