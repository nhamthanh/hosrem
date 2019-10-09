// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conference.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Conference _$ConferenceFromJson(Map<String, dynamic> json) {
  return Conference(
    json['id'] as int,
    json['title'] as String,
    json['description'] as String,
    json['photo_url'] as String,
  );
}

Map<String, dynamic> _$ConferenceToJson(Conference instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'photo_url': instance.photoUrl,
    };
