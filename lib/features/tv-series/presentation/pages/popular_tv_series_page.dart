import 'package:ditonton/features/tv-series/presentation/bloc/popular-tv-series/popular_tv_series_bloc.dart';
import 'package:ditonton/features/tv-series/presentation/widgets/tv_series_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-tv-series';

  @override
  _PopularTvSeriesPageState createState() => _PopularTvSeriesPageState();
}

class _PopularTvSeriesPageState extends State<PopularTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    context.read<PopularTvSeriesBloc>().add(OnGetPopularTvSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Popular TV Series')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularTvSeriesBloc, PopularTvSeriesState>(
          builder: (context, state) {
            if (state is PopularTvSeriesLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is PopularTvSeriesLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvSeries = state.tvSeriesList[index];
                  return TvSeriesCard(tvSeries);
                },
                itemCount: state.tvSeriesList.length,
              );
            } else if (state is PopularTvSeriesError) {
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
