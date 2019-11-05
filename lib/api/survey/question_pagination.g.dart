// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_pagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionPagination _$QuestionPaginationFromJson(Map<String, dynamic> json) {
  return QuestionPagination(
    json['totalSize'] as int,
    json['page'] as int,
    json['totalPage'] as int,
    json['size'] as int,
    (json['result'] as List)
        .map((e) => Question.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$QuestionPaginationToJson(QuestionPagination instance) =>
    <String, dynamic>{
      'totalSize': instance.totalItems,
      'page': instance.page,
      'totalPage': instance.totalPages,
      'size': instance.size,
      'result': instance.items,
    };
