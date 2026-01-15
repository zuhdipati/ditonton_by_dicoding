import 'dart:convert';

import 'package:ditonton/features/tv-series/data/models/episode_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../json_reader.dart';
import '../../dummy_data/dummy_objects.dart';

void main() {
  group("from json", () {
    test("should return a valid model fromjson", () {
      final Map<String, dynamic> jsonMap = json.decode(
        readJson('tv-series/dummy_data/tv_series_episode.json'),
      );

      final result = EpisodeModel.fromJson(jsonMap);

      expect(result, testTvSeriesEpisodeModel);
    });
  });

  group("to json", () {
    test("should return a valid model tojson", () {
      final Map<String, dynamic> expectedJsonMap = json.decode(
        readJson('tv-series/dummy_data/tv_series_episode.json'),
      );

      final result = testTvSeriesEpisodeModel.toJson();

      expect(result, expectedJsonMap);
    });
  });
}
