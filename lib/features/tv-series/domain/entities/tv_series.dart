import 'package:equatable/equatable.dart';

class TvSeries extends Equatable {
  final int id;
  final String? name;
  final String? overview;
  final String? posterPath;

  const TvSeries({
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
  });

  const TvSeries.watchlist({
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.name,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        overview,
        posterPath,
      ];
}