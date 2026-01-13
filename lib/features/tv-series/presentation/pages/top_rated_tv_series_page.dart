import 'package:ditonton/features/tv-series/presentation/bloc/top-rated-tv-series/top_rated_tv_series_bloc.dart';
import 'package:ditonton/features/tv-series/presentation/widgets/tv_series_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-tv-series';

  @override
  _TopRatedTvSeriesPageState createState() => _TopRatedTvSeriesPageState();
}

class _TopRatedTvSeriesPageState extends State<TopRatedTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    context.read<TopRatedTvSeriesBloc>().add(OnGetTopRatedTvSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Top Rated TV Series')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
          builder: (context, state) {
            if (state is TopRatedTvSeriesLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is TopRatedTvSeriesLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvSeries = state.tvSeriesList[index];
                  return TvSeriesCard(tvSeries);
                },
                itemCount: state.tvSeriesList.length,
              );
            } else if (state is TopRatedTvSeriesError) {
              return Center(
                key: Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
