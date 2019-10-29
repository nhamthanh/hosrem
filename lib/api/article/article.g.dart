// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Article _$ArticleFromJson(Map<String, dynamic> json) {
  return Article(
    json['id'] as String,
    json['title'] as String,
    json['description'] as String,
    json['location'] as String,
    json['mode'] as String,
    DateTime.parse(json['startTime'] as String),
    json['banner'] as String,
    json['status'] as String,
    (json['files'] as List)?.map((e) => e as String)?.toList(),
    (json['documents'] as List)
        ?.map((e) =>
            e == null ? null : Document.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'location': instance.location,
      'mode': instance.mode,
      'startTime': instance.startTime.toIso8601String(),
      'banner': instance.banner,
      'status': instance.status,
      'files': instance.files,
      'documents': instance.documents,
    };
