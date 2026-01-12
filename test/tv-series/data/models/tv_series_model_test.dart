import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  test("should be a subclass of entity", () async {
    final result = testTvSeriesModel.toEntity();
    expect(result, testTvSeries);
  });
}
