import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/features/movie/presentation/bloc/movie-detail/movie_detail_bloc.dart';
import 'package:ditonton/features/movie/presentation/bloc/now-playing/now_playing_bloc.dart';
import 'package:ditonton/features/movie/presentation/bloc/popular-movies/popular_movies_bloc.dart';
import 'package:ditonton/features/movie/presentation/bloc/top-rated-movies/top_rated_bloc.dart';
import 'package:ditonton/features/movie/presentation/pages/about_page.dart';
import 'package:ditonton/features/main_page.dart';
import 'package:ditonton/features/movie/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/features/movie/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/features/movie/presentation/pages/search_page.dart';
import 'package:ditonton/features/movie/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/features/movie/presentation/pages/watchlist_movies_page.dart';
import 'package:ditonton/features/tv-series/presentation/pages/popular_tv_series_page.dart';
import 'package:ditonton/features/tv-series/presentation/pages/search_tv_series_page.dart';
import 'package:ditonton/features/tv-series/presentation/pages/top_rated_tv_series_page.dart';
import 'package:ditonton/features/tv-series/presentation/pages/tv_series_detail_page.dart';
import 'package:ditonton/features/tv-series/presentation/pages/watchlist_tv_series_page.dart';
import 'package:ditonton/features/movie/presentation/bloc/movie_search_notifier.dart';
import 'package:ditonton/features/movie/presentation/bloc/watchlist_movie_notifier.dart';
import 'package:ditonton/features/tv-series/presentation/bloc/popular_tv_series_notifier.dart';
import 'package:ditonton/features/tv-series/presentation/bloc/top_rated_tv_series_notifier.dart';
import 'package:ditonton/features/tv-series/presentation/bloc/tv_series_detail_notifier.dart';
import 'package:ditonton/features/tv-series/presentation/bloc/tv_series_list_notifier.dart';
import 'package:ditonton/features/tv-series/presentation/bloc/tv_series_search_notifier.dart';
import 'package:ditonton/features/tv-series/presentation/bloc/watchlist_tv_series_notifier.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;

void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistMovieNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSeriesListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSeriesDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSeriesSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularTvSeriesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedTvSeriesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistTvSeriesNotifier>(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => di.locator<NowPlayingBloc>()),
          BlocProvider(create: (context) => di.locator<TopRatedBloc>()),
          BlocProvider(create: (context) => di.locator<PopularMoviesBloc>()),
          BlocProvider(create: (context) => di.locator<MovieDetailBloc>()),
        ],
        child: MaterialApp(
          title: 'Ditonton',
          theme: ThemeData.dark().copyWith(
            colorScheme: kColorScheme,
            primaryColor: kRichBlack,
            scaffoldBackgroundColor: kRichBlack,
            textTheme: kTextTheme,
            drawerTheme: kDrawerTheme,
          ),
          home: MainPage(),
          navigatorObservers: [routeObserver],
          onGenerateRoute: (RouteSettings settings) {
            switch (settings.name) {
              case '/main':
                return MaterialPageRoute(builder: (_) => MainPage());
              case PopularMoviesPage.ROUTE_NAME:
                return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
              case TopRatedMoviesPage.ROUTE_NAME:
                return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
              case MovieDetailPage.ROUTE_NAME:
                final id = settings.arguments as int;
                return MaterialPageRoute(
                  builder: (_) => MovieDetailPage(id: id),
                  settings: settings,
                );
              case SearchPage.ROUTE_NAME:
                return CupertinoPageRoute(builder: (_) => SearchPage());
              case WatchlistMoviesPage.ROUTE_NAME:
                return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
              case PopularTvSeriesPage.ROUTE_NAME:
                return CupertinoPageRoute(
                  builder: (_) => PopularTvSeriesPage(),
                );
              case TopRatedTvSeriesPage.ROUTE_NAME:
                return CupertinoPageRoute(
                  builder: (_) => TopRatedTvSeriesPage(),
                );
              case TvSeriesDetailPage.ROUTE_NAME:
                final id = settings.arguments as int;
                return MaterialPageRoute(
                  builder: (_) => TvSeriesDetailPage(id: id),
                  settings: settings,
                );
              case SearchTvSeriesPage.ROUTE_NAME:
                return CupertinoPageRoute(builder: (_) => SearchTvSeriesPage());
              case WatchlistTvSeriesPage.ROUTE_NAME:
                return MaterialPageRoute(
                  builder: (_) => WatchlistTvSeriesPage(),
                );
              case AboutPage.ROUTE_NAME:
                return MaterialPageRoute(builder: (_) => AboutPage());
              default:
                return MaterialPageRoute(
                  builder: (_) {
                    return Scaffold(
                      body: Center(child: Text('Page not found :(')),
                    );
                  },
                );
            }
          },
        ),
      ),
    );
  }
}
