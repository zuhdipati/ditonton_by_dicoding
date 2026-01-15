import 'dart:convert';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/env/env.dart';
import 'package:ditonton/features/tv-series/data/models/tv_series_detail_model.dart';
import 'package:ditonton/features/tv-series/data/models/episode_model.dart';
import 'package:ditonton/features/tv-series/data/models/season_detail_response.dart';
import 'package:ditonton/features/tv-series/data/models/tv_series_model.dart';
import 'package:ditonton/features/tv-series/data/models/tv_series_response.dart';
import 'package:http/http.dart' as http;

abstract class TvSeriesRemoteDataSource {
  Future<List<TvSeriesModel>> getAiringTodayTvSeries();
  Future<List<TvSeriesModel>> getPopularTvSeries();
  Future<List<TvSeriesModel>> getTopRatedTvSeries();
  Future<TvSeriesDetailModel> getTvSeriesDetail(int id);
  Future<List<TvSeriesModel>> getTvSeriesRecommendations(int id);
  Future<List<TvSeriesModel>> searchTvSeries(String query);
  Future<List<EpisodeModel>> getSeasonEpisodes(int id, int seasonNumber);
}

class TvSeriesRemoteDataSourceImpl implements TvSeriesRemoteDataSource {
  static final API_KEY = 'api_key=${Env.tmdbApiKey}';
  static const BASE_URL = 'https://api.themoviedb.org/3';

  final http.Client client;

  TvSeriesRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TvSeriesModel>> getAiringTodayTvSeries() async {
    final response = await client.get(
      Uri.parse('$BASE_URL/tv/airing_today?$API_KEY'),
    );
    if (response.statusCode != 200) {
      throw ServerException();
    }
    return TvSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;
  }

  @override
  Future<List<TvSeriesModel>> getPopularTvSeries() async {
    final response = await client.get(
      Uri.parse('$BASE_URL/tv/popular?$API_KEY'),
    );
    if (response.statusCode != 200) {
      throw ServerException();
    }
    return TvSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;
  }

  @override
  Future<List<TvSeriesModel>> getTopRatedTvSeries() async {
    final response = await client.get(
      Uri.parse('$BASE_URL/tv/top_rated?$API_KEY'),
    );
    if (response.statusCode != 200) {
      throw ServerException();
    }
    return TvSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;
  }

  @override
  Future<TvSeriesDetailModel> getTvSeriesDetail(int id) async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/$id?$API_KEY'));
    if (response.statusCode != 200) {
      throw ServerException();
    }
    return TvSeriesDetailModel.fromJson(json.decode(response.body));
  }

  @override
  Future<List<TvSeriesModel>> getTvSeriesRecommendations(int id) async {
    final response = await client.get(
      Uri.parse('$BASE_URL/tv/$id/recommendations?$API_KEY'),
    );
    if (response.statusCode != 200) {
      throw ServerException();
    }
    return TvSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;
  }

  @override
  Future<List<TvSeriesModel>> searchTvSeries(String query) async {
    final response = await client.get(
      Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query'),
    );
    if (response.statusCode != 200) {
      throw ServerException();
    }
    return TvSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;
  }

  @override
  Future<List<EpisodeModel>> getSeasonEpisodes(int id, int seasonNumber) async {
    final response = await client.get(
      Uri.parse('$BASE_URL/tv/$id/season/$seasonNumber?$API_KEY'),
    );
    if (response.statusCode != 200) {
      throw ServerException();
    }
    return SeasonDetailResponse.fromJson(json.decode(response.body)).episodes;
  }
}
