import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/movie/domain/entities/genre.dart';
import 'package:ditonton/features/tv-series/domain/entities/tv_series.dart';
import 'package:ditonton/features/tv-series/domain/entities/tv_series_detail.dart';
import 'package:ditonton/features/tv-series/presentation/bloc/tv-series-detail/tv_series_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class TvSeriesDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail-tv-series';

  final int id;
  TvSeriesDetailPage({required this.id});

  @override
  _TvSeriesDetailPageState createState() => _TvSeriesDetailPageState();
}

class _TvSeriesDetailPageState extends State<TvSeriesDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<TvSeriesDetailBloc>().add(OnGetTvSeriesDetail(widget.id));
    context.read<TvSeriesDetailBloc>().add(
      OnGetTvSeriesRecommendations(widget.id),
    );
    context.read<TvSeriesDetailBloc>().add(OnGetWatchlistStatus(widget.id));
    context.read<TvSeriesDetailBloc>().add(OnGetTvSeriesSeasons(widget.id, 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<TvSeriesDetailBloc, TvSeriesDetailState>(
        listener: (context, state) {
          final message = state.watchlistMessage;
          if (message == TvSeriesDetailBloc.watchlistAddSuccessMessage ||
              message == TvSeriesDetailBloc.watchlistRemoveSuccessMessage) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(message)));
          } else if (message.isNotEmpty) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(content: Text(message));
              },
            );
          }
        },
        listenWhen: (previous, current) =>
            previous.watchlistMessage != current.watchlistMessage &&
            current.watchlistMessage.isNotEmpty,
        builder: (context, state) {
          final tvSeriesState = state.tvSeriesDetailState;

          if (tvSeriesState == RequestState.Loading) {
            return Center(child: CircularProgressIndicator());
          } else if (tvSeriesState == RequestState.Error) {
            return Center(child: Text(state.message));
          } else if (tvSeriesState == RequestState.Loaded) {
            final tvSeries = state.tvSeriesDetail;
            return SafeArea(
              child: TvSeriesDetailContent(
                widget.id,
                tvSeries!,
                state.tvSeriesRecommendations,
                state.isAddedToWatchlist,
              ),
            );
          } else {
            return Text(state.message);
          }
        },
      ),
    );
  }
}

class TvSeriesDetailContent extends StatelessWidget {
  final int id;
  final TvSeriesDetail tvSeries;
  final List<TvSeries> recommendations;
  final bool isAddedWatchlist;

  TvSeriesDetailContent(
    this.id,
    this.tvSeries,
    this.recommendations,
    this.isAddedWatchlist,
  );

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tvSeries.posterPath}',
          width: screenWidth,
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(tvSeries.name, style: kHeading5),
                            FilledButton(
                              onPressed: () {
                                if (!isAddedWatchlist) {
                                  context.read<TvSeriesDetailBloc>().add(
                                    OnSaveWatchlist(tvSeries),
                                  );
                                } else {
                                  context.read<TvSeriesDetailBloc>().add(
                                    OnRemoveWatchlist(tvSeries),
                                  );
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isAddedWatchlist
                                      ? Icon(Icons.check)
                                      : Icon(Icons.add),
                                  Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(_showGenres(tvSeries.genres)),
                            Text(
                              '${tvSeries.numberOfSeasons} Seasons • ${tvSeries.numberOfEpisodes} Episodes',
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tvSeries.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) =>
                                      Icon(Icons.star, color: kMikadoYellow),
                                  itemSize: 24,
                                ),
                                Text('${tvSeries.voteAverage}'),
                              ],
                            ),
                            SizedBox(height: 16),
                            DropdownButtonFormField<int>(
                              initialValue: 1,
                              onChanged: (value) {
                                context.read<TvSeriesDetailBloc>().add(
                                  OnGetTvSeriesSeasons(id, value ?? 1),
                                );
                              },
                              decoration: InputDecoration(
                                labelText: 'Season',
                                labelStyle: kBodyText,
                              ),
                              items: List.generate(
                                tvSeries.numberOfSeasons,
                                (index) => DropdownMenuItem(
                                  value: index + 1,
                                  child: Text('Season ${index + 1}'),
                                ),
                              ),
                            ),
                            SizedBox(height: 16),
                            Text('Seasons', style: kHeading6),
                            SizedBox(height: 8),
                            BlocBuilder<
                              TvSeriesDetailBloc,
                              TvSeriesDetailState
                            >(
                              builder: (context, state) {
                                final seasonState = state.tvSeriesSeasonState;
                                if (seasonState == RequestState.Loading) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (seasonState == RequestState.Error) {
                                  return Text(state.message);
                                } else if (seasonState == RequestState.Loaded) {
                                  return SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final seasonItem =
                                            state.tvSeriesSeasons[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {},
                                            child: Column(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                        Radius.circular(8),
                                                      ),
                                                  child: Visibility(
                                                    visible:
                                                        seasonItem.stillPath !=
                                                        null,
                                                    replacement: Container(
                                                      color: Colors.grey,
                                                      height: 120,
                                                      width: 220,
                                                    ),
                                                    child: CachedNetworkImage(
                                                      height: 120,
                                                      width: 220,
                                                      imageUrl:
                                                          'https://image.tmdb.org/t/p/w500${seasonItem.stillPath}',
                                                      placeholder:
                                                          (
                                                            context,
                                                            url,
                                                          ) => Center(
                                                            child:
                                                                CircularProgressIndicator(),
                                                          ),
                                                      errorWidget:
                                                          (
                                                            context,
                                                            url,
                                                            error,
                                                          ) =>
                                                              Icon(Icons.error),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 220,
                                                  child: Text(
                                                    seasonItem.name,
                                                    textAlign: TextAlign.center,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: state.tvSeriesSeasons.length,
                                    ),
                                  );
                                }
                                return Container();
                              },
                            ),
                            SizedBox(height: 16),
                            Text('Overview', style: kHeading6),
                            Text(tvSeries.overview),
                            SizedBox(height: 16),
                            Text('Recommendations', style: kHeading6),
                            BlocBuilder<
                              TvSeriesDetailBloc,
                              TvSeriesDetailState
                            >(
                              builder: (context, state) {
                                final recommendationState =
                                    state.tvSeriesRecommendationState;
                                if (recommendationState ==
                                    RequestState.Loading) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (recommendationState ==
                                    RequestState.Error) {
                                  return Text(state.message);
                                } else if (recommendationState ==
                                    RequestState.Loaded) {
                                  return SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final tvSeriesItem = state
                                            .tvSeriesRecommendations[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                context,
                                                TvSeriesDetailPage.ROUTE_NAME,
                                                arguments: tvSeriesItem.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${tvSeriesItem.posterPath}',
                                                placeholder: (context, url) =>
                                                    Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount:
                                          state.tvSeriesRecommendations.length,
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            minChildSize: 0.25,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }
}
