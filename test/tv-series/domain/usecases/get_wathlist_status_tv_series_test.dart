import 'package:dartz/dartz.dart';
import 'package:ditonton/features/tv-series/domain/usecases/get_watchlist_tv_series_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/tv_series_test_helper.mocks.dart';

void main() {
 late GetWatchlistTvSeriesStatus usecase;
 late MockTvSeriesRepository mockTvSeriesRepository;

 setUp(() {
  mockTvSeriesRepository = MockTvSeriesRepository();
  usecase = GetWatchlistTvSeriesStatus(mockTvSeriesRepository);
 });

 test("should get watchlist status from the repository", () async {
  final tId = 1;

  when(mockTvSeriesRepository.isAddedToWatchlistTvSeries(tId))
      .thenAnswer((realInvocation) async => Right(true));

  final result = await usecase.execute(tId);

  expect(result, Right(true));
 });

}