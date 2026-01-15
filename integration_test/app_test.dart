import 'package:ditonton/features/movie/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ditonton/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    await GetIt.instance.reset();
  });

  testWidgets('home integration test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // movies tab
    expect(find.byKey(const Key('now_playing_loading')), findsNothing);
    await tester.pumpAndSettle();
    expect(find.text('Now Playing'), findsOneWidget);
    expect(find.text('Popular'), findsOneWidget);
    expect(find.text('Top Rated'), findsOneWidget);
    expect(find.byKey(const Key('now_playing_list')), findsOneWidget);

    // navigate to tv series tab
    await tester.tap(find.byIcon(Icons.tv).first);
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('airing_today_loading')), findsNothing);
    expect(find.text('Airing Today'), findsOneWidget);
    expect(find.text('Popular'), findsOneWidget);
    expect(find.text('Top Rated'), findsOneWidget);
    expect(find.byKey(const Key('airing_today_list')), findsOneWidget);

    // open drawer
    final ScaffoldState state = tester.firstState(find.byType(Scaffold));
    state.openDrawer();
    await tester.pumpAndSettle();

    // drawer items
    expect(find.byKey(const Key('moviesDrawer')), findsOneWidget);
    expect(find.byKey(const Key('tvSeriesDrawer')), findsOneWidget);
    expect(find.byKey(const Key('watchlistMoviesDrawer')), findsOneWidget);
    expect(find.byKey(const Key('watchlistTvSeriesDrawer')), findsOneWidget);
    expect(find.byKey(const Key('aboutDrawer')), findsOneWidget);
    await tester.pumpAndSettle();

    // navigate to watchlist movies
    await tester.tap(find.byKey(const Key('watchlistMoviesDrawer')));
    await tester.pumpAndSettle();
    expect(find.text('Watchlist'), findsOneWidget);
    expect(find.text('Watchlist TV Series'), findsNothing);
    await tester.pumpAndSettle();

    // back
    await tester.pageBack();
    await tester.pumpAndSettle();

    // navigate to watchlist tv series
    await tester.tap(find.byKey(const Key('watchlistTvSeriesDrawer')));
    await tester.pumpAndSettle();
    expect(find.text('Watchlist TV Series'), findsOneWidget);
    expect(find.text('Watchlist'), findsNothing);
    await tester.pumpAndSettle();

    // back
    await tester.pageBack();
    await tester.pumpAndSettle();

    // navigate to about
    await tester.tap(find.byKey(const Key('aboutDrawer')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('about_text')), findsOneWidget);
    await tester.tap(find.byKey(const Key('about_back_button')));
    await tester.pumpAndSettle();

    // close drawer by tapping outside
    await tester.tapAt(const Offset(300, 300));
  });

  testWidgets('search integration test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // movies tab
    expect(find.byKey(const Key('now_playing_loading')), findsNothing);
    await tester.pumpAndSettle();
    expect(find.text('Now Playing'), findsOneWidget);
    expect(find.text('Popular'), findsOneWidget);
    expect(find.text('Top Rated'), findsOneWidget);
    expect(find.byKey(const Key('now_playing_list')), findsOneWidget);

    // search
    await tester.tap(find.byIcon(Icons.search));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('search_textfield')), 'Avatar');
    await tester.pumpAndSettle();
    await tester.testTextInput.receiveAction(TextInputAction.search);
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('search_result')), findsOneWidget);
    expect(
      find.descendant(
        of: find.byType(MovieCard).first,
        matching: find.text('Avatar'),
      ),
      findsOneWidget,
    );
    await tester.pumpAndSettle();

    // back
    await tester.pageBack();
    await tester.pumpAndSettle();
  });

  testWidgets('movie detail integration test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // navigate to movie detail by tapping on first movie
    expect(find.byKey(const Key('now_playing_loading')), findsNothing);
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('now_playing_movie_item_0')));
    await tester.pumpAndSettle();

    // verify movie detail page loaded
    expect(find.byKey(const Key('movie_detail_title')), findsOneWidget);

    // verify movie metadata is displayed
    expect(find.byKey(const Key('movie_detail_genres')), findsOneWidget);
    expect(find.byKey(const Key('movie_detail_duration')), findsOneWidget);
    expect(find.byKey(const Key('movie_detail_rating')), findsOneWidget);

    // verify movie overview is displayed
    expect(find.byKey(const Key('movie_detail_overview')), findsOneWidget);
    expect(find.text('Overview'), findsOneWidget);

    // verify watchlist button is displayed
    expect(
      find.byKey(const Key('movie_detail_watchlist_button')),
      findsOneWidget,
    );

    // verify recommendations section
    expect(find.text('Recommendations'), findsOneWidget);

    // wait for recommendations to load
    await tester.pumpAndSettle();
    expect(
      find.byKey(const Key('movie_detail_recommendations_loading')),
      findsNothing,
    );

    // test watchlist add functionality
    final watchlistButton = find.byKey(
      const Key('movie_detail_watchlist_button'),
    );
    await tester.tap(watchlistButton);
    await tester.pumpAndSettle();

    // verify snackbar appears with success message
    expect(find.text('Added to Watchlist'), findsOneWidget);

    // wait for the snackbar to dismiss before next action
    await tester.pump(const Duration(seconds: 4));
    await tester.pumpAndSettle();

    // test watchlist remove functionality
    await tester.tap(watchlistButton);
    await tester.pumpAndSettle();

    // verify snackbar appears with remove success message
    expect(find.text('Removed from Watchlist'), findsOneWidget);
    await tester.pumpAndSettle();

    // navigate back
    final backButton = find.byKey(const Key('movie_detail_back_button'));
    expect(backButton, findsOneWidget);
    await tester.tap(backButton);
    await tester.pumpAndSettle();

    // verify
    expect(find.text('Now Playing'), findsOneWidget);
    expect(find.text('Popular'), findsOneWidget);
    expect(find.text('Top Rated'), findsOneWidget);
  });

  testWidgets('movie detail recommendation navigation test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // wait for movies to load on home page
    expect(find.byKey(const Key('now_playing_loading')), findsNothing);
    await tester.pumpAndSettle();

    // navigate to movie detail page
    await tester.tap(find.byKey(const Key('now_playing_movie_item_0')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('movie_detail_title')), findsOneWidget);
    await tester.pumpAndSettle();

    // check if recommendations list exists
    final recommendationsListFinder = find.byKey(
      const Key('movie_detail_recommendations_list'),
    );

    // if recommendations are available, test navigation
    if (tester.any(recommendationsListFinder)) {
      // scroll to see recommendations
      await tester.drag(
        find.byType(SingleChildScrollView).first,
        const Offset(0, -300),
      );
      await tester.pumpAndSettle();

      // tap on first recommendation
      final firstRecommendation = find.byKey(
        const Key('movie_detail_recommendation_0'),
      );
      if (tester.any(firstRecommendation)) {
        await tester.tap(firstRecommendation);
        await tester.pumpAndSettle();

        // verify new movie detail page loaded
        expect(find.byKey(const Key('movie_detail_title')), findsOneWidget);
        expect(
          find.byKey(const Key('movie_detail_watchlist_button')),
          findsOneWidget,
        );
      }
    }

    // navigate back to home
    await tester.tap(find.byKey(const Key('movie_detail_back_button')));
    await tester.pumpAndSettle();

    // may need to tap back again if we navigated to recommendation
    final backButton = find.byKey(const Key('movie_detail_back_button'));
    if (tester.any(backButton)) {
      await tester.tap(backButton);
      await tester.pumpAndSettle();
    }
  });

  testWidgets('tv series detail integration test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // navigate to tv series tab
    await tester.tap(find.byIcon(Icons.tv).first);
    await tester.pumpAndSettle();

    // wait for tv series to load
    expect(find.byKey(const Key('airing_today_loading')), findsNothing);
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('airing_today_item_0')));
    await tester.pumpAndSettle();

    // verify tv series detail page loaded
    expect(find.byKey(const Key('tv_series_detail_title')), findsOneWidget);
    expect(find.byKey(const Key('tv_series_detail_genres')), findsOneWidget);
    expect(
      find.byKey(const Key('tv_series_detail_episodes_info')),
      findsOneWidget,
    );
    expect(find.byKey(const Key('tv_series_detail_rating')), findsOneWidget);
    expect(find.byKey(const Key('tv_series_detail_overview')), findsOneWidget);
    expect(find.text('Overview'), findsOneWidget);
    expect(
      find.byKey(const Key('tv_series_detail_watchlist_button')),
      findsOneWidget,
    );
    expect(
      find.byKey(const Key('tv_series_detail_season_dropdown')),
      findsOneWidget,
    );
    expect(find.text('Seasons'), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.text('Recommendations'), findsOneWidget);
    await tester.pumpAndSettle();

    // test watchlist add functionality
    final watchlistButton = find.byKey(
      const Key('tv_series_detail_watchlist_button'),
    );
    await tester.tap(watchlistButton);
    await tester.pumpAndSettle();

    // verify snackbar appears with success message
    expect(find.text('Added to Watchlist'), findsOneWidget);

    // wait for the snackbar to dismiss before next action
    await tester.pump(const Duration(seconds: 4));
    await tester.pumpAndSettle();

    // test watchlist remove functionality
    await tester.tap(watchlistButton);
    await tester.pumpAndSettle();

    // verify snackbar appears with remove success message
    expect(find.text('Removed from Watchlist'), findsOneWidget);
    await tester.pumpAndSettle();

    // navigate back
    final backButton = find.byKey(const Key('tv_series_detail_back_button'));
    expect(backButton, findsOneWidget);
    await tester.tap(backButton);
    await tester.pumpAndSettle();

    // verify we're back at tv series home page
    expect(find.text('Airing Today'), findsOneWidget);
    expect(find.text('Popular'), findsOneWidget);
    expect(find.text('Top Rated'), findsOneWidget);
  });

  testWidgets('tv series season selection test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // navigate to tv series tab
    await tester.tap(find.byIcon(Icons.tv).first);
    await tester.pumpAndSettle();

    // wait for tv series to load
    expect(find.byKey(const Key('airing_today_loading')), findsNothing);
    await tester.pumpAndSettle();

    // navigate to tv series detail
    await tester.tap(find.byKey(const Key('airing_today_item_0')));
    await tester.pumpAndSettle();

    // verify tv series detail page loaded
    expect(find.byKey(const Key('tv_series_detail_title')), findsOneWidget);

    // wait for seasons to load
    await tester.pumpAndSettle();

    // check if season dropdown exists
    final seasonDropdown = find.byKey(
      const Key('tv_series_detail_season_dropdown'),
    );
    expect(seasonDropdown, findsOneWidget);

    // tap on season dropdown to open it
    await tester.tap(seasonDropdown);
    await tester.pumpAndSettle();

    // check if Season 2 option exists (if tv series has multiple seasons)
    final season2Option = find.text('Season 2');
    if (tester.any(season2Option)) {
      await tester.tap(season2Option.last);
      await tester.pumpAndSettle();

      // wait for season episodes to load
      await tester.pumpAndSettle();
    }

    // navigate back
    await tester.tap(find.byKey(const Key('tv_series_detail_back_button')));
    await tester.pumpAndSettle();
  });
}
