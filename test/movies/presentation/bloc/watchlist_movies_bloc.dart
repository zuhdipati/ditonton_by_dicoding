import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/features/movie/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/features/movie/presentation/bloc/watchlist-movies/watchlist_movies_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_movies_bloc.mocks.dart';

@GenerateMocks([GetWatchlistMovies])
void main() {
  late WatchlistMoviesBloc watchlistMoviesBloc;
  late MockGetWatchlistMovies mockGetWatchlistMovies;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    watchlistMoviesBloc = WatchlistMoviesBloc(
      getWatchlistMovies: mockGetWatchlistMovies,
    );
  });

  group("Watchlist Movie Bloc", () {
    test("initial state should be WatchlistMoviesInitial", () {
      expect(watchlistMoviesBloc.state, WatchlistMoviesInitial());
    });

    blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
      'emits [WatchlistMoviesLoading, WatchlistMoviesLoaded] when OnGetWatchlistMovies is added.',
      build: () {
        when(
          mockGetWatchlistMovies.execute(),
        ).thenAnswer((realInvocation) async => Right(testMovieList));
        return watchlistMoviesBloc;
      },
      act: (bloc) => bloc.add(OnGetWatchlistMovies()),
      expect: () => <WatchlistMoviesState>[
        WatchlistMoviesLoading(),
        WatchlistMoviesLoaded(testMovieList),
      ],
      verify: (bloc) => mockGetWatchlistMovies.execute(),
    );

    blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
      'emits [WatchlistMoviesLoading, WatchlistMoviesError] when OnGetWatchlistMovies is added.',
      build: () {
        when(mockGetWatchlistMovies.execute()).thenAnswer(
          (realInvocation) async => Left(ServerFailure("Server Failure")),
        );
        return watchlistMoviesBloc;
      },
      act: (bloc) => bloc.add(OnGetWatchlistMovies()),
      expect: () => <WatchlistMoviesState>[
        WatchlistMoviesLoading(),
        WatchlistMoviesError("Server Failure"),
      ],
      verify: (bloc) => mockGetWatchlistMovies.execute(),
    );
  });
}
