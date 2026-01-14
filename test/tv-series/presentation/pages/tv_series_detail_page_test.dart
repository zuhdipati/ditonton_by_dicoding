import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/tv-series/domain/entities/episode.dart';
import 'package:ditonton/features/tv-series/domain/entities/tv_series.dart';
import 'package:ditonton/features/tv-series/presentation/bloc/tv-series-detail/tv_series_detail_bloc.dart';
import 'package:ditonton/features/tv-series/presentation/pages/tv_series_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_detail_page_test.mocks.dart';

@GenerateMocks([TvSeriesDetailBloc])
void main() {
  late MockTvSeriesDetailBloc mockBloc;

  setUp(() {
    mockBloc = MockTvSeriesDetailBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TvSeriesDetailBloc>.value(
      value: mockBloc,
      child: MaterialApp(home: body),
    );
  }

  testWidgets(
    'Watchlist button should display add icon when tv series not added to watchlist',
    (WidgetTester tester) async {
      final testState = TvSeriesDetailState(
        tvSeriesDetailState: RequestState.Loaded,
        tvSeriesDetail: testTvSeriesDetail,
        tvSeriesRecommendationState: RequestState.Loaded,
        tvSeriesRecommendations: <TvSeries>[],
        tvSeriesSeasonState: RequestState.Loaded,
        tvSeriesSeasons: <Episode>[],
        isAddedToWatchlist: false,
        watchlistMessage: '',
        message: '',
      );

      when(mockBloc.state).thenReturn(testState);
      when(mockBloc.stream).thenAnswer((_) => Stream.value(testState));

      final watchlistButtonIcon = find.byIcon(Icons.add);

      await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: 1)));

      expect(watchlistButtonIcon, findsOneWidget);
    },
  );

  testWidgets(
    'Watchlist button should display check icon when tv series is added to watchlist',
    (WidgetTester tester) async {
      final testState = TvSeriesDetailState(
        tvSeriesDetailState: RequestState.Loaded,
        tvSeriesDetail: testTvSeriesDetail,
        tvSeriesRecommendationState: RequestState.Loaded,
        tvSeriesRecommendations: <TvSeries>[],
        tvSeriesSeasonState: RequestState.Loaded,
        tvSeriesSeasons: <Episode>[],
        isAddedToWatchlist: true,
        watchlistMessage: '',
        message: '',
      );

      when(mockBloc.state).thenReturn(testState);
      when(mockBloc.stream).thenAnswer((_) => Stream.value(testState));

      final watchlistButtonIcon = find.byIcon(Icons.check);

      await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: 1)));

      expect(watchlistButtonIcon, findsOneWidget);
    },
  );

  testWidgets(
    'Watchlist button should display Snackbar when added to watchlist',
    (WidgetTester tester) async {
      final initialState = TvSeriesDetailState(
        tvSeriesDetailState: RequestState.Loaded,
        tvSeriesDetail: testTvSeriesDetail,
        tvSeriesRecommendationState: RequestState.Loaded,
        tvSeriesRecommendations: <TvSeries>[],
        tvSeriesSeasonState: RequestState.Loaded,
        tvSeriesSeasons: <Episode>[],
        isAddedToWatchlist: false,
        watchlistMessage: '',
        message: '',
      );

      final updatedState = TvSeriesDetailState(
        tvSeriesDetailState: RequestState.Loaded,
        tvSeriesDetail: testTvSeriesDetail,
        tvSeriesRecommendationState: RequestState.Loaded,
        tvSeriesRecommendations: <TvSeries>[],
        tvSeriesSeasonState: RequestState.Loaded,
        tvSeriesSeasons: <Episode>[],
        isAddedToWatchlist: true,
        watchlistMessage: 'Added to Watchlist',
        message: '',
      );

      when(mockBloc.state).thenReturn(initialState);
      when(
        mockBloc.stream,
      ).thenAnswer((_) => Stream.fromIterable([initialState, updatedState]));

      await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: 1)));

      expect(find.byIcon(Icons.add), findsOneWidget);

      final watchlistButton = find.byType(FilledButton);
      await tester.tap(watchlistButton);
      await tester.pump();
    },
  );

  testWidgets(
    'Watchlist button should display AlertDialog when add to watchlist failed',
    (WidgetTester tester) async {
      final initialState = TvSeriesDetailState(
        tvSeriesDetailState: RequestState.Loaded,
        tvSeriesDetail: testTvSeriesDetail,
        tvSeriesRecommendationState: RequestState.Loaded,
        tvSeriesRecommendations: <TvSeries>[],
        tvSeriesSeasonState: RequestState.Loaded,
        tvSeriesSeasons: <Episode>[],
        isAddedToWatchlist: false,
        watchlistMessage: '',
        message: '',
      );

      final updatedState = TvSeriesDetailState(
        tvSeriesDetailState: RequestState.Loaded,
        tvSeriesDetail: testTvSeriesDetail,
        tvSeriesRecommendationState: RequestState.Loaded,
        tvSeriesRecommendations: <TvSeries>[],
        tvSeriesSeasonState: RequestState.Loaded,
        tvSeriesSeasons: <Episode>[],
        isAddedToWatchlist: false,
        watchlistMessage: 'Failed',
        message: '',
      );

      when(mockBloc.state).thenReturn(initialState);
      when(
        mockBloc.stream,
      ).thenAnswer((_) => Stream.fromIterable([initialState, updatedState]));

      await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: 1)));

      expect(find.byIcon(Icons.add), findsOneWidget);

      final watchlistButton = find.byType(FilledButton);
      await tester.tap(watchlistButton);
      await tester.pump();
    },
  );
}
