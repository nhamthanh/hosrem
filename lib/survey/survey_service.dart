import 'package:hosrem_app/api/survey/question.dart';
import 'package:hosrem_app/api/survey/question_result.dart';
import 'package:hosrem_app/api/survey/survey.dart';
import 'package:hosrem_app/api/survey/survey_result.dart';
import 'package:hosrem_app/network/api_provider.dart';

/// Survey service.
class SurveyService {
  SurveyService(this.apiProvider) : assert(apiProvider != null);

  final ApiProvider apiProvider;

  /// Get survey by conference [id].
  Future<Survey> getSurveyById(String id) async {
    final Survey survey = await apiProvider.surveyApi.getSurvey(<String, dynamic>{
      'confId': id,
      'includeQuestions': true
    });
    return survey;
  }

  /// Submit survey value.
  Future<void> submitSurveyResult(String conferenceId, String userId, Map<Question, String> values) async {
    final List<QuestionResult> questionResults =
        values.keys.map((Question question) => QuestionResult(values[question], question)).toList();
    await apiProvider.surveyApi.submitSurveyResult(SurveyResult(questionResults, conferenceId, userId));
  }

  /// Get survey result by survey result id [id].
  Future<List<QuestionResult>> getSurveyResult(String id) async {
    final SurveyResult surveyResult = await apiProvider.surveyApi.getSurveyResult(id);
    return surveyResult.answers;
  }
}
