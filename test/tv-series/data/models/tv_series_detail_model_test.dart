import 'dart:convert';

import 'package:ditonton/features/tv-series/data/models/tv_series_detail_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../json_reader.dart';
import '../../dummy_data/dummy_objects.dart';

void main() {
  group("fromjson", () {
    test("should return a valid model from json", () async {
      final Map<String, dynamic> jsonMap = json
          .decode(readJson('tv-series/dummy_data/tv_series_detail.json'));

      final result = TvSeriesDetailModel.fromJson(jsonMap);

      expect(result, testTvSeriesDetailModel);
    });
  });

  group("tojson", () {
    test("should return a valid model to json", () async {
      final Map<String, dynamic> expectedJsonMap = json
          .decode(readJson('tv-series/dummy_data/tv_series_detail.json'));

      final result = testTvSeriesDetailModel.toJson();

      expect(result, expectedJsonMap);
    });
  });
}
