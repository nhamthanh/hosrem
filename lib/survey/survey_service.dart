import 'package:hosrem_app/api/survey/survey.dart';
import 'package:hosrem_app/network/api_provider.dart';

/// Survey service.
class SurveyService {
  SurveyService(this.apiProvider) : assert(apiProvider != null);

  final ApiProvider apiProvider;

  /// Get conferences.
  Future<Survey> getSurveyById(String id) async {
    final Survey survey = await apiProvider.surveyApi.getSurvey(id);
    return survey;
  }
}
