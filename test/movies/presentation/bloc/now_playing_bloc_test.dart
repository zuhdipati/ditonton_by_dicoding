import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/features/movie/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/features/movie/presentation/bloc/now-playing/now_playing_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data/dummy_objects.dart';
import 'now_playing_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies])
void main() {
  late NowPlayingBloc nowPlayingBloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    nowPlayingBloc = NowPlayingBloc(
      getNowPlayingMovies: mockGetNowPlayingMovies,
    );
  });

  group('Now Playing Movies Bloc', () {
    test('initial state should be NowPlayingInitial', () {
      expect(nowPlayingBloc.state, NowPlayingInitial());
    });

    blocTest<NowPlayingBloc, NowPlayingState>(
      'should emit [NowPlayingLoading, NowPlayingLoaded] when success',
      build: () {
        when(
          mockGetNowPlayingMovies.execute(),
        ).thenAnswer((_) async => Right(testMovieList));
        return nowPlayingBloc;
      },
      act: (bloc) => bloc.add(OnGetNowPlayingMovies()),
      expect: () => [NowPlayingLoading(), NowPlayingLoaded(testMovieList)],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );

    blocTest<NowPlayingBloc, NowPlayingState>(
      'should emit [NowPlayingLoading, NowPlayingError] when unsuccess',
      build: () {
        when(
          mockGetNowPlayingMovies.execute(),
        ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return nowPlayingBloc;
      },
      act: (bloc) => bloc.add(OnGetNowPlayingMovies()),
      expect: () => [NowPlayingLoading(), NowPlayingError('Server Failure')],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );
  });
}
