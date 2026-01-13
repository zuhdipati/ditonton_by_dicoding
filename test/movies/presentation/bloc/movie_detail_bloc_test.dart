import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/features/movie/domain/entities/movie.dart';
import 'package:ditonton/features/movie/domain/entities/movie_detail.dart';
import 'package:ditonton/features/movie/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/features/movie/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/features/movie/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/features/movie/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/features/movie/domain/usecases/save_watchlist.dart';
import 'package:ditonton/features/movie/presentation/bloc/movie-detail/movie_detail_bloc.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetMovieRecommendations,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late MovieDetailBloc movieDetailBloc;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    movieDetailBloc = MovieDetailBloc(
      getMovieDetail: mockGetMovieDetail,
      getMovieRecommendations: mockGetMovieRecommendations,
      getWatchListStatus: mockGetWatchListStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    );
  });

  const tId = 1;

  final tMovieDetail = MovieDetail(
    adult: false,
    backdropPath: 'backdropPath',
    genres: [],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    runtime: 120,
    title: 'title',
    voteAverage: 1.0,
    voteCount: 1,
  );

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1.0,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1.0,
    voteCount: 1,
  );

  final tMovies = <Movie>[tMovie];

  group('Get Movie Detail', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'emits Loading and then Loaded when GetMovieDetail is successful',
      build: () {
        when(
          mockGetMovieDetail.execute(tId),
        ).thenAnswer((_) async => Right(tMovieDetail));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(const OnGetMovieDetail(tId)),
      expect: () => [
        const MovieDetailState(movieDetailState: RequestState.Loading),
        MovieDetailState(
          movieDetail: tMovieDetail,
          movieDetailState: RequestState.Loaded,
        ),
      ],
      verify: (_) {
        verify(mockGetMovieDetail.execute(tId));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'emits Loading and then Error when GetMovieDetail fails',
      build: () {
        when(
          mockGetMovieDetail.execute(tId),
        ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(const OnGetMovieDetail(tId)),
      expect: () => [
        const MovieDetailState(movieDetailState: RequestState.Loading),
        const MovieDetailState(
          message: 'Server Failure',
          movieDetailState: RequestState.Error,
        ),
      ],
      verify: (_) {
        verify(mockGetMovieDetail.execute(tId));
      },
    );
  });

  group('Get Movie Recommendations', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'emits Loading and then Loaded when GetMovieRecommendations is successful',
      build: () {
        when(
          mockGetMovieRecommendations.execute(tId),
        ).thenAnswer((_) async => Right(tMovies));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(const OnGetMovieRecommendations(tId)),
      expect: () => [
        const MovieDetailState(movieRecommendationState: RequestState.Loading),
        MovieDetailState(
          movieRecommendations: tMovies,
          movieRecommendationState: RequestState.Loaded,
        ),
      ],
      verify: (_) {
        verify(mockGetMovieRecommendations.execute(tId));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'emits Loading and then Error when GetMovieRecommendations fails',
      build: () {
        when(
          mockGetMovieRecommendations.execute(tId),
        ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(const OnGetMovieRecommendations(tId)),
      expect: () => [
        const MovieDetailState(movieRecommendationState: RequestState.Loading),
        const MovieDetailState(
          message: 'Server Failure',
          movieRecommendationState: RequestState.Error,
        ),
      ],
      verify: (_) {
        verify(mockGetMovieRecommendations.execute(tId));
      },
    );
  });

  group('Watchlist', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'emits isAddedToWatchlist true when watchlist status is true',
      build: () {
        when(mockGetWatchListStatus.execute(tId)).thenAnswer((_) async => true);
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(const OnGetWatchlist(tId)),
      expect: () => [const MovieDetailState(isAddedToWatchlist: true)],
      verify: (_) {
        verify(mockGetWatchListStatus.execute(tId));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'emits success message when SaveWatchlist is successful',
      build: () {
        when(
          mockSaveWatchlist.execute(tMovieDetail),
        ).thenAnswer((_) async => const Right('Added to Watchlist'));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(OnSaveWatchlist(tMovieDetail)),
      expect: () => [
        const MovieDetailState(
          watchlistMessage: 'Added to Watchlist',
          isAddedToWatchlist: true,
        ),
      ],
      verify: (_) {
        verify(mockSaveWatchlist.execute(tMovieDetail));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'emits success message when RemoveWatchlist is successful',
      build: () {
        when(
          mockRemoveWatchlist.execute(tMovieDetail),
        ).thenAnswer((_) async => const Right('Removed from Watchlist'));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(OnRemoveWatchlist(tMovieDetail)),
      expect: () => [
        const MovieDetailState(
          watchlistMessage: 'Removed from Watchlist',
          isAddedToWatchlist: false,
        ),
      ],
      verify: (_) {
        verify(mockRemoveWatchlist.execute(tMovieDetail));
      },
    );
  });
}
