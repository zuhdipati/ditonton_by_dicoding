import 'package:ditonton/features/tv-series/presentation/bloc/search-tv-series/search_tv_series_bloc.dart';
import 'package:ditonton/features/tv-series/presentation/bloc/tv-series-detail/tv_series_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  group('TV Series Events', () {
    group('OnGetTvSeriesDetail', () {
      test('supports value equality', () {
        expect(
          const OnGetTvSeriesDetail(1),
          equals(const OnGetTvSeriesDetail(1)),
        );
      });

      test('props are correct', () {
        expect(const OnGetTvSeriesDetail(1).props, [1]);
      });
    });

    group('OnGetTvSeriesRecommendations', () {
      test('supports value equality', () {
        expect(
          const OnGetTvSeriesRecommendations(1),
          equals(const OnGetTvSeriesRecommendations(1)),
        );
      });

      test('props are correct', () {
        expect(const OnGetTvSeriesRecommendations(1).props, [1]);
      });
    });

    group('OnGetWatchlistStatus', () {
      test('supports value equality', () {
        expect(
          const OnGetWatchlistStatus(1),
          equals(const OnGetWatchlistStatus(1)),
        );
      });

      test('props are correct', () {
        expect(const OnGetWatchlistStatus(1).props, [1]);
      });
    });

    group('OnSaveWatchlist', () {
      test('supports value equality', () {
        expect(
          OnSaveWatchlist(testTvSeriesDetail),
          equals(OnSaveWatchlist(testTvSeriesDetail)),
        );
      });

      test('props are correct', () {
        expect(OnSaveWatchlist(testTvSeriesDetail).props, [testTvSeriesDetail]);
      });
    });

    group('OnRemoveWatchlist', () {
      test('supports value equality', () {
        expect(
          OnRemoveWatchlist(testTvSeriesDetail),
          equals(OnRemoveWatchlist(testTvSeriesDetail)),
        );
      });

      test('props are correct', () {
        expect(OnRemoveWatchlist(testTvSeriesDetail).props, [
          testTvSeriesDetail,
        ]);
      });
    });

    group('OnSearchTvSeries', () {
      test('supports value equality', () {
        expect(
          const OnSearchTvSeries('dirty linen'),
          equals(const OnSearchTvSeries('dirty linen')),
        );
      });

      test('props are correct', () {
        expect(const OnSearchTvSeries('dirty linen').props, ['dirty linen']);
      });
    });
  });
}
