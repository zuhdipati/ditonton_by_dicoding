import 'package:ditonton/features/tv-series/data/models/episode_model.dart';
import 'package:equatable/equatable.dart';

class SeasonDetailResponse extends Equatable {
  final List<EpisodeModel> episodes;

  const SeasonDetailResponse({required this.episodes});

  factory SeasonDetailResponse.fromJson(Map<String, dynamic> json) {
    return SeasonDetailResponse(
      episodes: json['episodes'] != null
          ? List<EpisodeModel>.from(
              (json['episodes'] as List).map((x) => EpisodeModel.fromJson(x)),
            )
          : [],
    );
  }

  @override
  List<Object> get props => [episodes];
}
