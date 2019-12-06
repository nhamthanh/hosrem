// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurveyResult _$SurveyResultFromJson(Map<String, dynamic> json) {
  return SurveyResult(
    (json['answers'] as List)
        .map((e) => QuestionResult.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['conferenceId'] as String,
    json['userId'] as String,
    json['fullName'] as String,
    json['registrationCode'] as String,
  );
}

Map<String, dynamic> _$SurveyResultToJson(SurveyResult instance) =>
    <String, dynamic>{
      'conferenceId': instance.conferenceId,
      'fullName': instance.fullName,
      'registrationCode': instance.registrationCode,
      'userId': instance.userId,
      'answers': instance.answers,
    };
