import 'dart:convert';

import 'package:ditonton/features/tv-series/data/models/tv_series_model.dart';
import 'package:ditonton/features/tv-series/data/models/tv_series_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../json_reader.dart';
import '../../dummy_data/dummy_objects.dart';

void main() {
  final testTvSeriesResponseModel = TvSeriesResponse(
    tvSeriesList: <TvSeriesModel>[testTvSeriesModel],
  );

  group("fromjson", () {
    test('should return a valid model from json', () async {
      final Map<String, dynamic> jsonMap = json.decode(
        readJson('tv-series/dummy_data/airing_today_tv_series.json'),
      );

      final result = TvSeriesResponse.fromJson(jsonMap);

      expect(result, testTvSeriesResponseModel);
    });
  });

  group("tojson", () {
    test('should return a valid model to json', () async {
      final Map<String, dynamic> expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "/mAJ84W6I8I272Da87qplS2Dp9ST.jpg",
            "first_air_date": "2023-01-23",
            "genre_ids": [9648, 18],
            "id": 202250,
            "name": "Dirty Linen",
            "origin_country": ["PH"],
            "original_language": "tl",
            "original_name": "Dirty Linen",
            "overview":
                "To exact vengeance, a young woman infiltrates the household of an influential family as a housemaid to expose their dirty secrets. However, love will get in the way of her revenge plot.",
            "popularity": 2797.914,
            "poster_path": "/aoAZgnmMzY9vVy9VWnO3U5PZENh.jpg",
            "vote_average": 5,
            "vote_count": 13,
          },
        ],
      };

      final result = testTvSeriesResponseModel.toJson();

      expect(result, expectedJsonMap);
    });
  });
}
