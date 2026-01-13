import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/features/tv-series/presentation/bloc/watchlist-tv-series/watchlist_tv_series_bloc.dart';
import 'package:ditonton/features/tv-series/presentation/widgets/tv_series_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-tv-series';

  @override
  _WatchlistTvSeriesPageState createState() => _WatchlistTvSeriesPageState();
}

class _WatchlistTvSeriesPageState extends State<WatchlistTvSeriesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    context.read<WatchlistTvSeriesBloc>().add(OnGetWatchlistTvSeries());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<WatchlistTvSeriesBloc>().add(OnGetWatchlistTvSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Watchlist TV Series')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
          builder: (context, state) {
            if (state is WatchlistTvSeriesLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is WatchlistTvSeriesLoaded) {
              if (state.result.isEmpty) {
                return Center(
                  child: Text('No Watchlist TV Series', style: kSubtitle),
                );
              }
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvSeries = state.result[index];
                  return TvSeriesCard(tvSeries);
                },
                itemCount: state.result.length,
              );
            } else if (state is WatchlistTvSeriesError) {
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

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
