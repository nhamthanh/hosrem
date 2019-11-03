// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Article _$ArticleFromJson(Map<String, dynamic> json) {
  return Article(
    json['id'] as String,
    json['avatar'] as String,
    json['author'] as String,
    json['content'] as String,
    json['category'] == null
        ? null
        : Category.fromJson(json['category'] as Map<String, dynamic>),
    json['title'] as String,
    json['source'] as String,
    DateTime.parse(json['publishTime'] as String),
    json['status'] as String,
  );
}

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
      'id': instance.id,
      'avatar': instance.avatar,
      'author': instance.author,
      'content': instance.content,
      'category': instance.category,
      'title': instance.title,
      'source': instance.source,
      'publishTime': instance.publishTime.toIso8601String(),
      'status': instance.status,
    };
