import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'question_pagination.dart';
import 'survey.dart';

part 'survey_api.g.dart';

/// Survey Api.
@RestApi()
abstract class SurveyApi {
  factory SurveyApi(Dio dio) = _SurveyApi;

  /// Get survey by [id].
//  @GET('survey/{id}')
  @GET('conferences/c0a8e004-6dc3-1f74-816d-c4342d770000/fees')
  Future<Survey> getSurvey(@Path() String id);

  /// Get all questions by section [sectionId].
//  @GET('survey/{id}/sections/{sectionId}')
//  Future<QuestionPagination> getAllQuestions(@Path() String id, @Path() String sectionId, @Queries() Map<String, dynamic> query);
  @GET('conferences')
  Future<QuestionPagination> getAllQuestions(@Queries() Map<String, dynamic> query);
}

