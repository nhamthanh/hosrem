import 'package:hosrem_app/api/survey/survey.dart';
import 'package:meta/meta.dart';

/// Survey Introduction state.
@immutable
abstract class SurveyIntroductionState {
}

/// SurveyIntroductionLoading state.
class SurveyIntroductionLoading extends SurveyIntroductionState {
  @override
  String toString() => 'SurveyIntroductionLoading';
}

/// SurveyFailure state.
class SurveyIntroductionFailure extends SurveyIntroductionState {
  SurveyIntroductionFailure({@required this.error});

  final String error;

  @override
  String toString() => 'SurveyIntroductionFailure { error: $error }';
}

/// LoadedSurveyIntroduction state.
class LoadedSurveyIntroduction extends SurveyIntroductionState {
  LoadedSurveyIntroduction(this.survey, {this.surveyResultId = '' });

  final Survey survey;

  final String surveyResultId;

  @override
  String toString() => 'LoadedSurveyIntroduction';
}

/// UnauthorizeSurveyIntroduction state.
class UnauthorizeSurveyIntroduction extends SurveyIntroductionState {
  UnauthorizeSurveyIntroduction();

  @override
  String toString() => 'UnauthorizeSurveyIntroduction';
}

