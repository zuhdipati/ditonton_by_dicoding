import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/features/movie/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/features/movie/presentation/bloc/popular-movies/popular_movies_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'popular_movies_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late PopularMoviesBloc popularMoviesBloc;
  late MockGetPopularMovies mockGetPopularMovies;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    popularMoviesBloc = PopularMoviesBloc(
      getPopularMovies: mockGetPopularMovies,
    );
  });

  group("Popular Movies Bloc", () {
    test('initial state should be PopularMoviesInitial', () {
      expect(popularMoviesBloc.state, PopularMoviesInitial());
    });

    blocTest<PopularMoviesBloc, PopularMoviesState>(
      "emits [PopularMoviesLoading, PopularMoviesLoaded] when OnGetPopularMovies is added.",
      build: () {
        when(
          mockGetPopularMovies.execute(),
        ).thenAnswer((_) async => Right(testMovieList));
        return popularMoviesBloc;
      },
      act: (bloc) => bloc.add(OnGetPopularMovies()),
      expect: () => <PopularMoviesState>[
        PopularMoviesLoading(),
        PopularMoviesLoaded(testMovieList),
      ],
      verify: (bloc) => mockGetPopularMovies.execute(),
    );

    blocTest<PopularMoviesBloc, PopularMoviesState>(
      'emits [PopularMoviesLoading ,PopularMoviesError] when OnGetPopularMovies is added.',
      build: () {
        when(mockGetPopularMovies.execute()).thenAnswer(
          (realInvocation) async => Left(ServerFailure("Server Failure")),
        );
        return popularMoviesBloc;
      },
      act: (bloc) => bloc.add(OnGetPopularMovies()),
      expect: () => <PopularMoviesState>[
        PopularMoviesLoading(),
        PopularMoviesError("Server Failure"),
      ],
      verify: (bloc) => mockGetPopularMovies.execute(),
    );
  });
}
