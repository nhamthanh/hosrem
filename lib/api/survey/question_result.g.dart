// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionResult _$QuestionResultFromJson(Map<String, dynamic> json) {
  return QuestionResult(
    json['answer'] as String,
    Question.fromJson(json['question'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$QuestionResultToJson(QuestionResult instance) =>
    <String, dynamic>{
      'answer': instance.answer,
      'question': instance.question,
    };
