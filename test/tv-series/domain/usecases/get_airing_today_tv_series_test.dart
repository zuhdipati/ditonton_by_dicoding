import 'package:dartz/dartz.dart';
import 'package:ditonton/features/tv-series/domain/usecases/get_airing_today_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/tv_series_test_helper.mocks.dart';

void main() {
  late GetAiringTodayTvSeries usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetAiringTodayTvSeries(mockTvSeriesRepository);
  });

  test("should get list of tv series from the repo", () async {
    when(
      mockTvSeriesRepository.getAiringTodayTvSeries(),
    ).thenAnswer((realInvocation) async => Right(testTvSeriesList));

    final result = await usecase.execute();

    expect(result, Right(testTvSeriesList));
  });
}
