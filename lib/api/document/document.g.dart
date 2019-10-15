// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Document _$DocumentFromJson(Map<String, dynamic> json) {
  return Document(
    json['id'] as String,
    json['content'] as String,
    DateTime.parse(json['createdTime'] as String),
    json['previewImg'] as String,
    json['speakers'] as String,
    json['speakingTime'] as String,
    json['title'] as String,
    docType: json['docType'] as String,
  );
}

Map<String, dynamic> _$DocumentToJson(Document instance) => <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'createdTime': instance.createdTime.toIso8601String(),
      'previewImg': instance.previewImg,
      'speakers': instance.speakers,
      'speakingTime': instance.speakingTime,
      'title': instance.title,
      'docType': instance.docType,
    };
