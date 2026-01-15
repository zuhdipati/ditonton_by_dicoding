import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/features/movie/domain/entities/movie.dart';
import 'package:ditonton/features/movie/presentation/bloc/now-playing/now_playing_bloc.dart';
import 'package:ditonton/features/movie/presentation/bloc/popular-movies/popular_movies_bloc.dart';
import 'package:ditonton/features/movie/presentation/bloc/top-rated-movies/top_rated_bloc.dart';
import 'package:ditonton/features/movie/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/features/movie/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/features/movie/presentation/pages/top_rated_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeMoviePage extends StatefulWidget {
  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
    context.read<NowPlayingBloc>().add(OnGetNowPlayingMovies());
    context.read<TopRatedBloc>().add(OnGetTopRatedMovies());
    context.read<PopularMoviesBloc>().add(OnGetPopularMovies());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Now Playing', style: kHeading6),
            BlocBuilder<NowPlayingBloc, NowPlayingState>(
              key: const Key('now_playing_list'),
              builder: (context, state) {
                if (state is NowPlayingLoading) {
                  return Center(
                    key: const Key('now_playing_loading'),
                    child: CircularProgressIndicator(),
                  );
                } else if (state is NowPlayingLoaded) {
                  return MovieList(state.movies, keyPrefix: 'now_playing');
                } else if (state is NowPlayingError) {
                  return Center(child: Text(state.message));
                } else {
                  return Container();
                }
              },
            ),
            _buildSubHeading(
              title: 'Popular',
              onTap: () =>
                  Navigator.pushNamed(context, PopularMoviesPage.ROUTE_NAME),
            ),
            BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
              builder: (context, state) {
                if (state is PopularMoviesLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is PopularMoviesLoaded) {
                  return MovieList(state.movies, keyPrefix: 'popular');
                } else if (state is PopularMoviesError) {
                  return Center(child: Text(state.message));
                } else {
                  return Container();
                }
              },
            ),
            _buildSubHeading(
              title: 'Top Rated',
              onTap: () =>
                  Navigator.pushNamed(context, TopRatedMoviesPage.ROUTE_NAME),
            ),
            BlocBuilder<TopRatedBloc, TopRatedState>(
              builder: (context, state) {
                if (state is TopRatedLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is TopRatedLoaded) {
                  return MovieList(state.movies, keyPrefix: 'top_rated');
                } else if (state is TopRatedError) {
                  return Center(child: Text(state.message));
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: kHeading6),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;
  final String keyPrefix;

  MovieList(this.movies, {this.keyPrefix = 'movie'});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            key: Key('${keyPrefix}_movie_item_$index'),
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MovieDetailPage.ROUTE_NAME,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
