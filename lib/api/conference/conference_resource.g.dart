// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conference_resource.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConferenceResource _$ConferenceResourceFromJson(Map<String, dynamic> json) {
  return ConferenceResource(
    json['id'] as int,
    json['title'] as String,
    json['description'] as String,
    json['pdf_url'] as String,
  );
}

Map<String, dynamic> _$ConferenceResourceToJson(ConferenceResource instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'pdf_url': instance.pdfUrl,
    };
