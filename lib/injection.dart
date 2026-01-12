import 'package:ditonton/data/db/database_helper.dart';
import 'package:ditonton/features/movie/data/datasources/movie_local_data_source.dart';
import 'package:ditonton/features/movie/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/features/movie/presentation/bloc/movie-detail/movie_detail_bloc.dart';
import 'package:ditonton/features/movie/presentation/bloc/now-playing/now_playing_bloc.dart';
import 'package:ditonton/features/movie/presentation/bloc/popular-movies/popular_movies_bloc.dart';
import 'package:ditonton/features/movie/presentation/bloc/top-rated-movies/top_rated_bloc.dart';
import 'package:ditonton/features/tv-series/data/datasources/tv_series_local_data_source.dart';
import 'package:ditonton/features/tv-series/data/datasources/tv_series_remote_data_source.dart';
import 'package:ditonton/features/movie/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/features/tv-series/data/repositories/tv_series_repository_impl.dart';
import 'package:ditonton/features/movie/domain/repositories/movie_repository.dart';
import 'package:ditonton/features/tv-series/domain/repositories/tv_series_repository.dart';
import 'package:ditonton/features/movie/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/features/movie/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/features/movie/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/features/movie/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/features/movie/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/features/movie/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/features/movie/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/features/movie/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/features/movie/domain/usecases/save_watchlist.dart';
import 'package:ditonton/features/movie/domain/usecases/search_movies.dart';
import 'package:ditonton/features/tv-series/domain/usecases/get_airing_today_tv_series.dart';
import 'package:ditonton/features/tv-series/domain/usecases/get_popular_tv_series.dart';
import 'package:ditonton/features/tv-series/domain/usecases/get_top_rated_tv_series.dart';
import 'package:ditonton/features/tv-series/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton/features/tv-series/domain/usecases/get_tv_series_recomendations.dart';
import 'package:ditonton/features/tv-series/domain/usecases/get_watchlist_tv_series.dart';
import 'package:ditonton/features/tv-series/domain/usecases/get_watchlist_tv_series_status.dart';
import 'package:ditonton/features/tv-series/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:ditonton/features/tv-series/domain/usecases/save_watchlist_tv_series.dart';
import 'package:ditonton/features/tv-series/domain/usecases/search_tv_series.dart';
import 'package:ditonton/features/movie/presentation/bloc/movie_search_notifier.dart';
import 'package:ditonton/features/movie/presentation/bloc/watchlist_movie_notifier.dart';
import 'package:ditonton/features/tv-series/presentation/bloc/popular_tv_series_notifier.dart';
import 'package:ditonton/features/tv-series/presentation/bloc/top_rated_tv_series_notifier.dart';
import 'package:ditonton/features/tv-series/presentation/bloc/tv_series_detail_notifier.dart';
import 'package:ditonton/features/tv-series/presentation/bloc/tv_series_list_notifier.dart';
import 'package:ditonton/features/tv-series/presentation/bloc/tv_series_search_notifier.dart';
import 'package:ditonton/features/tv-series/presentation/bloc/watchlist_tv_series_notifier.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  // movie providers
  locator.registerFactory(() => MovieSearchNotifier(searchMovies: locator()));
  locator.registerFactory(
    () => WatchlistMovieNotifier(getWatchlistMovies: locator()),
  );

  // movie bloc
  locator.registerFactory(() => NowPlayingBloc(getNowPlayingMovies: locator()));
  locator.registerFactory(() => TopRatedBloc(getTopRatedMovies: locator()));
  locator.registerFactory(() => PopularMoviesBloc(getPopularMovies: locator()));
  locator.registerFactory(
    () => MovieDetailBloc(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );

  // movie use cases
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  // movie repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // movie data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
    () => MovieRemoteDataSourceImpl(client: locator()),
  );
  locator.registerLazySingleton<MovieLocalDataSource>(
    () => MovieLocalDataSourceImpl(databaseHelper: locator()),
  );

  // movie database helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // tv series providers
  locator.registerFactory(
    () => TvSeriesListNotifier(
      getAiringTodayTvSeries: locator(),
      getPopularTvSeries: locator(),
      getTopRatedTvSeries: locator(),
    ),
  );
  locator.registerFactory(
    () => TvSeriesDetailNotifier(
      getTvSeriesDetail: locator(),
      getTvSeriesRecommendations: locator(),
      getWatchlistTvSeriesStatus: locator(),
      saveWatchlistTvSeries: locator(),
      removeWatchlistTvSeries: locator(),
    ),
  );
  locator.registerFactory(
    () => TvSeriesSearchNotifier(searchTvSeries: locator()),
  );
  locator.registerFactory(() => PopularTvSeriesNotifier(locator()));
  locator.registerFactory(
    () => TopRatedTvSeriesNotifier(getTopRatedTvSeries: locator()),
  );
  locator.registerFactory(
    () => WatchlistTvSeriesNotifier(getWatchlistTvSeries: locator()),
  );

  // tv series use cases
  locator.registerLazySingleton(() => GetAiringTodayTvSeries(locator()));
  locator.registerLazySingleton(() => GetPopularTvSeries(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvSeries(locator()));
  locator.registerLazySingleton(() => GetTvSeriesDetail(locator()));
  locator.registerLazySingleton(() => GetTvSeriesRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTvSeries(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvSeriesStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTvSeries(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTvSeries(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvSeries(locator()));

  // tv series repository
  locator.registerLazySingleton<TvSeriesRepository>(
    () => TvSeriesRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // tv series data sources
  locator.registerLazySingleton<TvSeriesRemoteDataSource>(
    () => TvSeriesRemoteDataSourceImpl(client: locator()),
  );
  locator.registerLazySingleton<TvSeriesLocalDataSource>(
    () => TvSeriesLocalDataSourceImpl(databaseHelper: locator()),
  );

  // external

  // eksternal
  locator.registerLazySingleton(() => http.Client());
}
