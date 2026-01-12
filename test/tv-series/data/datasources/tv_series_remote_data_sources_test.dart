import 'dart:convert';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/env/env.dart';
import 'package:ditonton/features/tv-series/data/datasources/tv_series_remote_data_source.dart';
import 'package:ditonton/features/tv-series/data/models/tv_series_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../../json_reader.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  final API_KEY = 'api_key=${Env.tmdbApiKey}';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late TvSeriesRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TvSeriesRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get airing today tv series', () {
    final tvSeriesList = TvSeriesResponse.fromJson(json.decode(
            readJson('tv-series/dummy_data/airing_today_tv_series.json')))
        .tvSeriesList;

    test('should return list of tv series when the response code is 200',
        () async {
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY')))
          .thenAnswer((_) async => http.Response(
              readJson('tv-series/dummy_data/airing_today_tv_series.json'),
              200));

      final result = await dataSource.getAiringTodayTvSeries();

      expect(result, equals(tvSeriesList));
    });

    test('should throw ServerException when the response code is 404 or other',
        () async {
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final call = dataSource.getAiringTodayTvSeries();

      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
