import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/features/tv-series/domain/entities/tv_series.dart';
import 'package:ditonton/features/tv-series/presentation/bloc/airing-today/airing_today_bloc.dart';
import 'package:ditonton/features/tv-series/presentation/bloc/popular-tv-series/popular_tv_series_bloc.dart';
import 'package:ditonton/features/tv-series/presentation/bloc/top-rated-tv-series/top_rated_tv_series_bloc.dart';
import 'package:ditonton/features/tv-series/presentation/pages/popular_tv_series_page.dart';
import 'package:ditonton/features/tv-series/presentation/pages/top_rated_tv_series_page.dart';
import 'package:ditonton/features/tv-series/presentation/pages/tv_series_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeTvSeriesContent extends StatefulWidget {
  @override
  _HomeTvSeriesContentState createState() => _HomeTvSeriesContentState();
}

class _HomeTvSeriesContentState extends State<HomeTvSeriesContent> {
  @override
  void initState() {
    super.initState();
    context.read<AiringTodayBloc>().add(const OnGetAiringTodayTvSeries());
    context.read<PopularTvSeriesBloc>().add(OnGetPopularTvSeries());
    context.read<TopRatedTvSeriesBloc>().add(OnGetTopRatedTvSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Airing Today', style: kHeading6),
            BlocBuilder<AiringTodayBloc, AiringTodayState>(
              key: const Key('airing_today_list'),
              builder: (context, state) {
                if (state is AiringTodayLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      key: const Key('airing_today_loading'),
                    ),
                  );
                } else if (state is AiringTodayLoaded) {
                  return TvSeriesHomeList(
                    state.tvSeriesList,
                    keyPrefix: 'airing_today',
                  );
                } else if (state is AiringTodayError) {
                  return Center(child: Text(state.message));
                } else {
                  return Container();
                }
              },
            ),
            _buildSubHeading(
              title: 'Popular',
              onTap: () =>
                  Navigator.pushNamed(context, PopularTvSeriesPage.ROUTE_NAME),
            ),
            BlocBuilder<PopularTvSeriesBloc, PopularTvSeriesState>(
              builder: (context, state) {
                if (state is PopularTvSeriesLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is PopularTvSeriesLoaded) {
                  return TvSeriesHomeList(
                    state.tvSeriesList,
                    keyPrefix: 'popular_tv',
                  );
                } else if (state is PopularTvSeriesError) {
                  return Center(child: Text(state.message));
                } else {
                  return Container();
                }
              },
            ),
            _buildSubHeading(
              title: 'Top Rated',
              onTap: () =>
                  Navigator.pushNamed(context, TopRatedTvSeriesPage.ROUTE_NAME),
            ),
            BlocBuilder<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
              builder: (context, state) {
                if (state is TopRatedTvSeriesLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is TopRatedTvSeriesLoaded) {
                  return TvSeriesHomeList(
                    state.tvSeriesList,
                    keyPrefix: 'top_rated_tv',
                  );
                } else if (state is TopRatedTvSeriesError) {
                  return Center(child: Text(state.message));
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: kHeading6),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TvSeriesHomeList extends StatelessWidget {
  final List<TvSeries> tvSeriesList;
  final String keyPrefix;

  TvSeriesHomeList(this.tvSeriesList, {this.keyPrefix = 'tv_series'});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tvSeries = tvSeriesList[index];
          return Container(
            key: Key('${keyPrefix}_item_$index'),
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TvSeriesDetailPage.ROUTE_NAME,
                  arguments: tvSeries.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tvSeries.posterPath}',
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvSeriesList.length,
      ),
    );
  }
}
