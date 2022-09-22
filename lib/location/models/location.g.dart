// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationResponse _$LocationResponseFromJson(Map<String, dynamic> json) =>
    LocationResponse(
      info: Info.fromJson(json['info'] as Map<String, dynamic>),
      results: (json['results'] as List<dynamic>)
          .map((e) => LocationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LocationResponseToJson(LocationResponse instance) =>
    <String, dynamic>{
      'info': instance.info,
      'results': instance.results,
    };

Info _$InfoFromJson(Map<String, dynamic> json) => Info(
      count: json['count'] as int,
      pages: json['pages'] as int,
    );

Map<String, dynamic> _$InfoToJson(Info instance) => <String, dynamic>{
      'count': instance.count,
      'pages': instance.pages,
    };

LocationModel _$LocationModelFromJson(Map<String, dynamic> json) =>
    LocationModel(
      id: json['id'] as int,
      name: json['name'] as String,
      type: json['type'] as String,
      dimension: json['dimension'] as String,
      residents:
          (json['residents'] as List<dynamic>).map((e) => e as String).toList(),
      url: json['url'] as String,
      created: json['created'] as String,
    );

Map<String, dynamic> _$LocationModelToJson(LocationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'dimension': instance.dimension,
      'residents': instance.residents,
      'url': instance.url,
      'created': instance.created,
    };
