import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/features/tv-series/domain/usecases/get_airing_today_tv_series.dart';
import 'package:ditonton/features/tv-series/presentation/bloc/airing-today/airing_today_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'airing_today_bloc_test.mocks.dart';

@GenerateMocks([GetAiringTodayTvSeries])
void main() {
  late AiringTodayBloc airingTodayBloc;
  late MockGetAiringTodayTvSeries mockGetAiringTodayTvSeries;

  setUp(() {
    mockGetAiringTodayTvSeries = MockGetAiringTodayTvSeries();
    airingTodayBloc = AiringTodayBloc(
      getAiringTodayTvSeries: mockGetAiringTodayTvSeries,
    );
  });

  group('Airing Today TV Series Bloc', () {
    test('initial state should be AiringTodayInitial', () {
      expect(airingTodayBloc.state, AiringTodayInitial());
    });

    blocTest<AiringTodayBloc, AiringTodayState>(
      'emits [AiringTodayLoading, AiringTodayLoaded] when success',
      build: () {
        when(
          mockGetAiringTodayTvSeries.execute(),
        ).thenAnswer((_) async => Right(testTvSeriesList));
        return airingTodayBloc;
      },
      act: (bloc) => bloc.add(const OnGetAiringTodayTvSeries()),
      expect: () => [AiringTodayLoading(), AiringTodayLoaded(testTvSeriesList)],
      verify: (bloc) {
        verify(mockGetAiringTodayTvSeries.execute());
      },
    );

    blocTest<AiringTodayBloc, AiringTodayState>(
      'emits [AiringTodayLoading, AiringTodayError] when unsuccess',
      build: () {
        when(
          mockGetAiringTodayTvSeries.execute(),
        ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return airingTodayBloc;
      },
      act: (bloc) => bloc.add(const OnGetAiringTodayTvSeries()),
      expect: () => [AiringTodayLoading(), AiringTodayError('Server Failure')],
      verify: (bloc) {
        verify(mockGetAiringTodayTvSeries.execute());
      },
    );
  });
}
