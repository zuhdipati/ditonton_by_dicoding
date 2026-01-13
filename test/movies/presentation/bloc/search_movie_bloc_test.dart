import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/features/movie/domain/usecases/search_movies.dart';
import 'package:ditonton/features/movie/presentation/bloc/search-movies/search_movies_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'search_movie_bloc_test.mocks.dart';

@GenerateMocks([SearchMovies])
void main() {
  late SearchMoviesBloc searchMoviesBloc;
  late MockSearchMovies mockSearchMovies;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    searchMoviesBloc = SearchMoviesBloc(searchMovies: mockSearchMovies);
  });

  group("Search Movie Bloc", () {
    test("initial state should be SearchMoviesInitial", () {
      expect(searchMoviesBloc.state, SearchMoviesInitial());
    });

    blocTest<SearchMoviesBloc, SearchMoviesState>(
      'emits [SearchMoviesLoading, SearchMoviesLoaded] when success',
      build: () {
        when(
          mockSearchMovies.execute("avatar"),
        ).thenAnswer((_) async => Right(testMovieList));
        return searchMoviesBloc;
      },
      act: (bloc) => bloc.add(const OnSearchMovies("avatar")),
      expect: () => <SearchMoviesState>[
        SearchMoviesLoading(),
        SearchMoviesLoaded(testMovieList),
      ],
      verify: (bloc) {
        verify(mockSearchMovies.execute("avatar"));
      },
    );

    blocTest<SearchMoviesBloc, SearchMoviesState>(
      'emits [SearchMoviesLoading, SearchMoviesError] when unsuccess',
      build: () {
        when(
          mockSearchMovies.execute("avatar"),
        ).thenAnswer((_) async => Left(ServerFailure("Server Failure")));
        return searchMoviesBloc;
      },
      act: (bloc) => bloc.add(const OnSearchMovies("avatar")),
      expect: () => <SearchMoviesState>[
        SearchMoviesLoading(),
        SearchMoviesError("Server Failure"),
      ],
      verify: (bloc) {
        verify(mockSearchMovies.execute("avatar"));
      },
    );
  });
}
