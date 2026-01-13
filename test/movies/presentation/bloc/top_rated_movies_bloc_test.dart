import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/features/movie/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/features/movie/presentation/bloc/top-rated-movies/top_rated_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'top_rated_movies_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late TopRatedBloc topRatedMoviesBloc;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    topRatedMoviesBloc = TopRatedBloc(getTopRatedMovies: mockGetTopRatedMovies);
  });

  group("Top Rated Movies Bloc", () {
    test("initial state should be TopRatedInitial", () {
      expect(topRatedMoviesBloc.state, TopRatedInitial());
    });

    blocTest<TopRatedBloc, TopRatedState>(
      'emits [TopRatedLoading, TopRatedLoaded] when OnGetTopRatedMovies is added.',
      build: () {
        when(
          mockGetTopRatedMovies.execute(),
        ).thenAnswer((realInvocation) async => Right(testMovieList));
        return topRatedMoviesBloc;
      },
      act: (bloc) => bloc.add(OnGetTopRatedMovies()),
      expect: () => <TopRatedState>[
        TopRatedLoading(),
        TopRatedLoaded(testMovieList),
      ],
      verify: (bloc) => mockGetTopRatedMovies.execute(),
    );

    blocTest<TopRatedBloc, TopRatedState>(
      'emits [TopRatedLoading, TopRatedError] when OnGetTopRatedMovies is added.',
      build: () {
        when(mockGetTopRatedMovies.execute()).thenAnswer(
          (realInvocation) async => Left(ServerFailure("Server Failure")),
        );
        return topRatedMoviesBloc;
      },
      act: (bloc) => bloc.add(OnGetTopRatedMovies()),
      expect: () => <TopRatedState>[
        TopRatedLoading(),
        TopRatedError("Server Failure"),
      ],
      verify: (bloc) => mockGetTopRatedMovies.execute(),
    );
  });
}
