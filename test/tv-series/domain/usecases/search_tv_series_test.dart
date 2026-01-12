import 'package:dartz/dartz.dart';
import 'package:ditonton/features/tv-series/domain/usecases/search_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/tv_series_test_helper.mocks.dart';

void main() {
  late SearchTvSeries usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = SearchTvSeries(mockTvSeriesRepository);
  });

  test("should return list of tv series when data is successfully fetched",
      () async {
    when(mockTvSeriesRepository.searchTvSeries('the'))
        .thenAnswer((realInvocation) async => Right(testTvSeriesList));

    final result = await usecase.execute('the');

    expect(result, Right(testTvSeriesList));
  });
}
