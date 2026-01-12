import 'package:ditonton/data/db/database_helper.dart';
import 'package:ditonton/features/tv-series/data/datasources/tv_series_local_data_source.dart';
import 'package:ditonton/features/tv-series/data/datasources/tv_series_remote_data_source.dart';
import 'package:ditonton/features/tv-series/domain/repositories/tv_series_repository.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';

@GenerateMocks(
  [
    TvSeriesRepository,
    TvSeriesRemoteDataSource,
    TvSeriesLocalDataSource,
    DatabaseHelper,
  ],
  customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
)
void main() {}
