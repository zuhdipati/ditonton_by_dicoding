import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/features/movie/presentation/bloc/movie-detail/movie_detail_bloc.dart';
import 'package:ditonton/features/movie/presentation/bloc/now-playing/now_playing_bloc.dart';
import 'package:ditonton/features/movie/presentation/bloc/popular-movies/popular_movies_bloc.dart';
import 'package:ditonton/features/movie/presentation/bloc/search-movies/search_movies_bloc.dart';
import 'package:ditonton/features/movie/presentation/bloc/top-rated-movies/top_rated_bloc.dart';
import 'package:ditonton/features/movie/presentation/bloc/watchlist-movies/watchlist_movies_bloc.dart';
import 'package:ditonton/features/movie/presentation/pages/about_page.dart';
import 'package:ditonton/features/main_page.dart';
import 'package:ditonton/features/movie/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/features/movie/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/features/movie/presentation/pages/search_page.dart';
import 'package:ditonton/features/movie/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/features/movie/presentation/pages/watchlist_movies_page.dart';
import 'package:ditonton/features/tv-series/presentation/bloc/airing-today/airing_today_bloc.dart';
import 'package:ditonton/features/tv-series/presentation/bloc/popular-tv-series/popular_tv_series_bloc.dart';
import 'package:ditonton/features/tv-series/presentation/bloc/search-tv-series/search_tv_series_bloc.dart';
import 'package:ditonton/features/tv-series/presentation/bloc/top-rated-tv-series/top_rated_tv_series_bloc.dart';
import 'package:ditonton/features/tv-series/presentation/bloc/tv-series-detail/tv_series_detail_bloc.dart';
import 'package:ditonton/features/tv-series/presentation/bloc/watchlist-tv-series/watchlist_tv_series_bloc.dart';
import 'package:ditonton/features/tv-series/presentation/pages/popular_tv_series_page.dart';
import 'package:ditonton/features/tv-series/presentation/pages/search_tv_series_page.dart';
import 'package:ditonton/features/tv-series/presentation/pages/top_rated_tv_series_page.dart';
import 'package:ditonton/features/tv-series/presentation/pages/tv_series_detail_page.dart';
import 'package:ditonton/features/tv-series/presentation/pages/watchlist_tv_series_page.dart';
import 'package:ditonton/firebase_options.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ditonton/injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await di.init();
  await di.locator.allReady();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.locator<NowPlayingBloc>()),
        BlocProvider(create: (context) => di.locator<TopRatedBloc>()),
        BlocProvider(create: (context) => di.locator<PopularMoviesBloc>()),
        BlocProvider(create: (context) => di.locator<SearchMoviesBloc>()),
        BlocProvider(create: (context) => di.locator<WatchlistMoviesBloc>()),
        BlocProvider(create: (context) => di.locator<AiringTodayBloc>()),
        BlocProvider(create: (context) => di.locator<PopularTvSeriesBloc>()),
        BlocProvider(create: (context) => di.locator<TopRatedTvSeriesBloc>()),
        BlocProvider(create: (context) => di.locator<SearchTvSeriesBloc>()),
        BlocProvider(create: (context) => di.locator<WatchlistTvSeriesBloc>()),
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
        navigatorObservers: [
          FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
          routeObserver,
        ],
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
                builder: (_) => BlocProvider(
                  create: (_) => di.locator<MovieDetailBloc>(),
                  child: MovieDetailPage(id: id),
                ),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case PopularTvSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularTvSeriesPage());
            case TopRatedTvSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedTvSeriesPage());
            case TvSeriesDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => BlocProvider(
                  create: (_) => di.locator<TvSeriesDetailBloc>(),
                  child: TvSeriesDetailPage(id: id),
                ),
                settings: settings,
              );
            case SearchTvSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchTvSeriesPage());
            case WatchlistTvSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistTvSeriesPage());
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
    );
  }
}
