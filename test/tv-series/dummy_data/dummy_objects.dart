import 'package:ditonton/features/movie/data/models/genre_model.dart';
import 'package:ditonton/features/tv-series/data/models/season_model.dart';
import 'package:ditonton/features/tv-series/data/models/tv_series_detail_model.dart';
import 'package:ditonton/features/tv-series/data/models/tv_series_model.dart';
import 'package:ditonton/features/tv-series/data/models/tv_series_table.dart';
import 'package:ditonton/features/movie/domain/entities/genre.dart';
import 'package:ditonton/features/tv-series/domain/entities/season.dart';
import 'package:ditonton/features/tv-series/domain/entities/tv_series.dart';
import 'package:ditonton/features/tv-series/domain/entities/tv_series_detail.dart';

final testTvSeriesModel = TvSeriesModel(
  backdropPath: "/mAJ84W6I8I272Da87qplS2Dp9ST.jpg",
  firstAirDate: "2023-01-23",
  genreIds: [9648, 18],
  id: 202250,
  name: "Dirty Linen",
  originCountry: ["PH"],
  originalLanguage: "tl",
  originalName: "Dirty Linen",
  overview:
      "To exact vengeance, a young woman infiltrates the household of an influential family as a housemaid to expose their dirty secrets. However, love will get in the way of her revenge plot.",
  popularity: 2797.914,
  posterPath: "/aoAZgnmMzY9vVy9VWnO3U5PZENh.jpg",
  voteAverage: 5.0,
  voteCount: 13,
);

final testTvSeriesModelList = <TvSeriesModel>[testTvSeriesModel];

final testTvSeries = TvSeries(
  id: 202250,
  name: 'Dirty Linen',
  overview:
      'To exact vengeance, a young woman infiltrates the household of an influential family as a housemaid to expose their dirty secrets. However, love will get in the way of her revenge plot.',
  posterPath: '/aoAZgnmMzY9vVy9VWnO3U5PZENh.jpg',
);

final testTvSeriesList = <TvSeries>[testTvSeries];

final testTvSeriesDetailModel = TvSeriesDetailModel(
  adult: false,
  backdropPath: "/mAJ84W6I8I272Da87qplS2Dp9ST.jpg",
  episodeRunTime: [30],
  firstAirDate: '2023-01-23',
  genres: [
    GenreModel(id: 18, name: "Drama"),
    GenreModel(id: 9648, name: "Mystery"),
  ],
  id: 202250,
  name: "Dirty Linen",
  numberOfEpisodes: 153,
  numberOfSeasons: 2,
  originalLanguage: "tl",
  originalName: "Dirty Linen",
  overview:
      "To exact vengeance, a young woman infiltrates the household of an influential family as a housemaid to expose their dirty secrets. However, love will get in the way of her revenge plot.",
  popularity: 4.3211,
  posterPath: "/fiK3u7oQb2Nsi2kuR73RRyIIGDD.jpg",
  seasons: [
    SeasonModel(
      airDate: "2023-01-23",
      episodeCount: 73,
      id: 294181,
      name: "Season 1",
      overview: "",
      posterPath: "/pVBxYfshGajQ600OKv8K4y8TI0K.jpg",
      seasonNumber: 1,
      voteAverage: 8.5,
    ),
    SeasonModel(
      airDate: "2023-05-08",
      episodeCount: 80,
      id: 338907,
      name: "Season 2",
      overview: "",
      posterPath: "/8o5v2GwX7ko0q3Vq5BXTt3WFfZo.jpg",
      seasonNumber: 2,
      voteAverage: 0.0,
    ),
  ],
  status: "Ended",
  tagline: "",
  type: "Scripted",
  voteAverage: 6.6,
  voteCount: 106,
);

final testTvSeriesDetail = TvSeriesDetail(
  backdropPath: "/mAJ84W6I8I272Da87qplS2Dp9ST.jpg",
  episodeRunTime: [30],
  firstAirDate: '2023-01-23',
  genres: [
    Genre(id: 18, name: "Drama"),
    Genre(id: 9648, name: "Mystery"),
  ],
  id: 202250,
  name: "Dirty Linen",
  numberOfEpisodes: 153,
  numberOfSeasons: 2,
  overview:
      "To exact vengeance, a young woman infiltrates the household of an influential family as a housemaid to expose their dirty secrets. However, love will get in the way of her revenge plot.",
  posterPath: "/fiK3u7oQb2Nsi2kuR73RRyIIGDD.jpg",
  seasons: [
    Season(
      episodeCount: 73,
      id: 294181,
      name: "Season 1",
      posterPath: "/pVBxYfshGajQ600OKv8K4y8TI0K.jpg",
      seasonNumber: 1,
    ),
    Season(
      episodeCount: 80,
      id: 338907,
      name: "Season 2",
      posterPath: "/8o5v2GwX7ko0q3Vq5BXTt3WFfZo.jpg",
      seasonNumber: 2,
    ),
  ],
  voteAverage: 6.6,
);

final testWatchlistTvSeries = TvSeries.watchlist(
  id: 202250,
  name: 'Dirty Linen',
  posterPath: '/fiK3u7oQb2Nsi2kuR73RRyIIGDD.jpg',
  overview:
      'To exact vengeance, a young woman infiltrates the household of an influential family as a housemaid to expose their dirty secrets. However, love will get in the way of her revenge plot.',
);

final testTvSeriesTable = TvSeriesTable(
  id: 202250,
  name: 'Dirty Linen',
  posterPath: '/fiK3u7oQb2Nsi2kuR73RRyIIGDD.jpg',
  overview:
      'To exact vengeance, a young woman infiltrates the household of an influential family as a housemaid to expose their dirty secrets. However, love will get in the way of her revenge plot.',
);

final testTvSeriesMap = {
  'id': 202250,
  'overview':
      'To exact vengeance, a young woman infiltrates the household of an influential family as a housemaid to expose their dirty secrets. However, love will get in the way of her revenge plot.',
  'posterPath': '/fiK3u7oQb2Nsi2kuR73RRyIIGDD.jpg',
  'name': 'Dirty Linen',
};
