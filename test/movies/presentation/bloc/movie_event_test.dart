import 'package:ditonton/features/movie/presentation/bloc/movie-detail/movie_detail_bloc.dart';
import 'package:ditonton/features/movie/presentation/bloc/search-movies/search_movies_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MovieDetailEvent', () {
    group('OnGetMovieDetail', () {
      test('supports value equality', () {
        expect(const OnGetMovieDetail(1), equals(const OnGetMovieDetail(1)));
      });

      test('props are correct', () {
        const event = OnGetMovieDetail(1);
        expect(event.props, [1]);
      });
    });

    group('OnGetMovieRecommendations', () {
      test('supports value equality', () {
        expect(
          const OnGetMovieRecommendations(1),
          equals(const OnGetMovieRecommendations(1)),
        );
      });

      test('props are correct', () {
        expect(const OnGetMovieRecommendations(1).props, [1]);
      });
    });

    group('OnGetWatchlist', () {
      test('supports value equality', () {
        expect(const OnGetWatchlist(1), equals(const OnGetWatchlist(1)));
      });

      test('props are correct', () {
        expect(const OnGetWatchlist(1).props, [1]);
      });
    });

    group("OnSearchMovies", () {
      test('supports value equality', () {
        expect(
          const OnSearchMovies("avatar"),
          equals(const OnSearchMovies("avatar")),
        );
      });

      test('props are correct', () {
        expect(const OnSearchMovies("avatar").props, ["avatar"]);
      });
    });
  });
}
