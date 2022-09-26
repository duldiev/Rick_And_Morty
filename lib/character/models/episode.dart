import 'package:json_annotation/json_annotation.dart';
part 'episode.g.dart';

@JsonSerializable()
class EpisodeModel {
  int id;
  String name;
  @JsonKey(name: "air_date")
  String airDate;
  String episode;
  String url;
  String created;

  EpisodeModel({
    required this.id,
    required this.name,
    required this.airDate,
    required this.episode,
    required this.url,
    required this.created,
  });

  factory EpisodeModel.fromJson(Map<String, dynamic> json) =>
      _$EpisodeModelFromJson(json);
}
