import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/movie/domain/entities/movie.dart';
import 'package:ditonton/features/movie/presentation/bloc/movie-detail/movie_detail_bloc.dart';
import 'package:ditonton/features/movie/presentation/pages/movie_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_page_detail_test.mocks.dart';

@GenerateMocks([MovieDetailBloc])
void main() {
  late MockMovieDetailBloc mockBloc;

  setUp(() {
    mockBloc = MockMovieDetailBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MovieDetailBloc>.value(
      value: mockBloc,
      child: MaterialApp(home: body),
    );
  }

  testWidgets(
    'Watchlist button should display add icon when movie not added to watchlist',
    (WidgetTester tester) async {
      final testState = MovieDetailState(
        movieDetailState: RequestState.Loaded,
        movieDetail: testMovieDetail,
        movieRecommendationState: RequestState.Loaded,
        movieRecommendations: <Movie>[],
        isAddedToWatchlist: false,
        watchlistMessage: '',
        message: '',
      );

      when(mockBloc.state).thenReturn(testState);
      when(mockBloc.stream).thenAnswer((_) => Stream.value(testState));

      final watchlistButtonIcon = find.byIcon(Icons.add);

      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

      expect(watchlistButtonIcon, findsOneWidget);
    },
  );

  testWidgets(
    'Watchlist button should display check icon when movie is added to watchlist',
    (WidgetTester tester) async {
      final testState = MovieDetailState(
        movieDetailState: RequestState.Loaded,
        movieDetail: testMovieDetail,
        movieRecommendationState: RequestState.Loaded,
        movieRecommendations: <Movie>[],
        isAddedToWatchlist: true,
        watchlistMessage: '',
        message: '',
      );

      when(mockBloc.state).thenReturn(testState);
      when(mockBloc.stream).thenAnswer((_) => Stream.value(testState));

      final watchlistButtonIcon = find.byIcon(Icons.check);

      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

      expect(watchlistButtonIcon, findsOneWidget);
    },
  );

  testWidgets(
    'Watchlist button should display Snackbar when added to watchlist',
    (WidgetTester tester) async {
      final initialState = MovieDetailState(
        movieDetailState: RequestState.Loaded,
        movieDetail: testMovieDetail,
        movieRecommendationState: RequestState.Loaded,
        movieRecommendations: <Movie>[],
        isAddedToWatchlist: false,
        watchlistMessage: '',
        message: '',
      );

      final updatedState = MovieDetailState(
        movieDetailState: RequestState.Loaded,
        movieDetail: testMovieDetail,
        movieRecommendationState: RequestState.Loaded,
        movieRecommendations: <Movie>[],
        isAddedToWatchlist: true,
        watchlistMessage: 'Added to Watchlist',
        message: '',
      );

      when(mockBloc.state).thenReturn(initialState);
      when(
        mockBloc.stream,
      ).thenAnswer((_) => Stream.fromIterable([initialState, updatedState]));

      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

      expect(find.byIcon(Icons.add), findsOneWidget);

      final watchlistButton = find.byType(FilledButton);
      await tester.tap(watchlistButton);
      await tester.pump();
    },
  );

  testWidgets(
    'Watchlist button should display AlertDialog when add to watchlist failed',
    (WidgetTester tester) async {
      final initialState = MovieDetailState(
        movieDetailState: RequestState.Loaded,
        movieDetail: testMovieDetail,
        movieRecommendationState: RequestState.Loaded,
        movieRecommendations: <Movie>[],
        isAddedToWatchlist: false,
        watchlistMessage: '',
        message: '',
      );

      final updatedState = MovieDetailState(
        movieDetailState: RequestState.Loaded,
        movieDetail: testMovieDetail,
        movieRecommendationState: RequestState.Loaded,
        movieRecommendations: <Movie>[],
        isAddedToWatchlist: false,
        watchlistMessage: 'Failed',
        message: '',
      );

      when(mockBloc.state).thenReturn(initialState);
      when(
        mockBloc.stream,
      ).thenAnswer((_) => Stream.fromIterable([initialState, updatedState]));

      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

      expect(find.byIcon(Icons.add), findsOneWidget);

      final watchlistButton = find.byType(FilledButton);
      await tester.tap(watchlistButton);
      await tester.pump();
    },
  );
}
