import 'package:equatable/equatable.dart';

class Season extends Equatable {
  final int id;
  final String name;
  final String posterPath;
  final int episodeCount;
  final int seasonNumber;

  const Season({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.episodeCount,
    required this.seasonNumber,
  });

  @override
  List<Object?> get props => [id, name, posterPath, episodeCount, seasonNumber];
}
