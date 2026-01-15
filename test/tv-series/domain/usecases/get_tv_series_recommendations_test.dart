import 'package:dartz/dartz.dart';
import 'package:ditonton/features/tv-series/domain/usecases/get_tv_series_recomendations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/tv_series_test_helper.mocks.dart';

void main() {
  late GetTvSeriesRecommendations usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetTvSeriesRecommendations(mockTvSeriesRepository);
  });

  final tId = 1;

  test("should get tv series recommendations from the repository", () async {
    when(
      mockTvSeriesRepository.getTvSeriesRecommendations(tId),
    ).thenAnswer((realInvocation) async => Right(testTvSeriesList));

    final result = await usecase.execute(tId);

    expect(result, Right(testTvSeriesList));
  });
}
