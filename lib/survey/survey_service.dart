import 'package:hosrem_app/api/conference/conference_auth.dart';
import 'package:hosrem_app/api/survey/question.dart';
import 'package:hosrem_app/api/survey/question_result.dart';
import 'package:hosrem_app/api/survey/survey.dart';
import 'package:hosrem_app/api/survey/survey_result.dart';
import 'package:hosrem_app/auth/auth_service.dart';
import 'package:hosrem_app/network/api_provider.dart';

/// Survey service.
class SurveyService {
  SurveyService(this.apiProvider, this.authService) : assert(apiProvider != null), assert(authService != null);

  final ApiProvider apiProvider;
  final AuthService authService;

  /// Get survey by conference [id].
  Future<Survey> getSurveyById(String id) async {
    final ConferenceAuth conferenceAuth = await authService.getConferenceAuth(id);
    if (conferenceAuth != null) {
      return apiProvider.surveyApi.getSurveyWli(<String, dynamic>{
        'confId': id,
        'includeQuestions': true,
        'fullName': conferenceAuth.fullName,
        'regCode': conferenceAuth.regCode
      });
    }

    return apiProvider.surveyApi.getSurvey(<String, dynamic>{
      'confId': id,
      'includeQuestions': true
    });
  }

  /// Submit survey value.
  Future<void> submitSurveyResult(String conferenceId, String userId, Map<Question, String> values, { String surveyResultId = '' }) async {
    final List<QuestionResult> questionResults =
        values.keys.map((Question question) => QuestionResult(values[question], question)).toList();
    final ConferenceAuth conferenceAuth = await authService.getConferenceAuth(conferenceId);
    if (surveyResultId.isEmpty) {
      if (conferenceAuth == null) {
        await apiProvider.surveyApi.submitSurveyResult(SurveyResult(questionResults, conferenceId, userId, null, null));
      } else {
        await apiProvider.surveyApi.submitSurveyResultWli(SurveyResult(questionResults, conferenceId, userId,
          conferenceAuth.fullName, conferenceAuth.regCode));
      }
    } else {
      if (conferenceAuth == null) {
        await apiProvider.surveyApi.updateSurveyResult(surveyResultId, SurveyResult(questionResults, conferenceId,
          userId, null, null));
      } else {
        await apiProvider.surveyApi.updateSurveyResultWli(surveyResultId, SurveyResult(questionResults, conferenceId,
          userId, conferenceAuth.fullName, conferenceAuth.regCode));
      }
    }
  }

  /// Get survey result by survey result id [id].
  Future<List<QuestionResult>> getSurveyResult(String id) async {
    final SurveyResult surveyResult = await apiProvider.surveyApi.getSurveyResult(id);
    return surveyResult.answers;
  }
}
