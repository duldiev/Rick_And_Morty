import 'package:json_annotation/json_annotation.dart';
part 'character.g.dart';

@JsonSerializable()
class CharacterResponse {
  List<CharacterModel> results;

  CharacterResponse({
    required this.results,
  });

  factory CharacterResponse.fromJson(Map<String, dynamic> json) =>
      _$CharacterResponseFromJson(json);
}

@JsonSerializable()
class CharacterModel {
  int id;
  String name;
  String status;
  String species;
  String type;
  String gender;
  Origin origin;
  Origin location;
  String image;
  List<String> episode;
  String url;
  String created;

  CharacterModel({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episode,
    required this.url,
    required this.created,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) =>
      _$CharacterModelFromJson(json);
}

@JsonSerializable()
class Origin {
  String name;
  String url;

  Origin({
    required this.name,
    required this.url,
  });

  factory Origin.fromJson(Map<String, dynamic> json) => _$OriginFromJson(json);
}
