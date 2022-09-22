import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

@JsonSerializable()
class LocationResponse {
  Info info;
  List<LocationModel> results;

  LocationResponse({
    required this.info,
    required this.results,
  });

  factory LocationResponse.fromJson(Map<String, dynamic> json) =>
      _$LocationResponseFromJson(json);
}

@JsonSerializable()
class Info {
  int count;
  int pages;

  Info({
    required this.count,
    required this.pages,
  });

  factory Info.fromJson(Map<String, dynamic> json) => _$InfoFromJson(json);
}

@JsonSerializable()
class LocationModel {
  int id;
  String name;
  String type;
  String dimension;
  List<String> residents;
  String url;
  String created;

  LocationModel({
    required this.id,
    required this.name,
    required this.type,
    required this.dimension,
    required this.residents,
    required this.url,
    required this.created,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) =>
      _$LocationModelFromJson(json);
}
