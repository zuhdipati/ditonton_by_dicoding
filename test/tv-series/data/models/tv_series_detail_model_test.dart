import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  test("should be equal to tv series detail model", () {
    final result = testTvSeriesDetailModel.toEntity();
    expect(result, testTvSeriesDetail);
  });
}
