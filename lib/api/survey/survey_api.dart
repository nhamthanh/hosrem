import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'question_pagination.dart';
import 'survey.dart';
import 'survey_result.dart';

part 'survey_api.g.dart';

/// Survey Api.
@RestApi()
abstract class SurveyApi {
  factory SurveyApi(Dio dio) = _SurveyApi;

  /// Get survey by [confId].
  @GET('surveys')
  Future<Survey> getSurvey(@Queries() Map<String, dynamic> query);

  /// Get all questions by section [sectionId].
  @GET('surveys/{sectionId}/questions')
  Future<QuestionPagination> getQuestionsBySectionId(@Path() String sectionId, @Queries() Map<String, dynamic> query);

  /// Submit survey result.
  @POST('survey-results')
  Future<SurveyResult> submitSurveyResult(@Body() SurveyResult surveyResult);

  /// Get survey result.
  @GET('survey-results/{id}')
  Future<SurveyResult> getSurveyResult(@Path() String id);
}

