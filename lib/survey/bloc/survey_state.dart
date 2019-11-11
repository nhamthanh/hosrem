import 'package:hosrem_app/api/survey/question.dart';
import 'package:hosrem_app/api/survey/survey.dart';
import 'package:meta/meta.dart';

/// Survey state.
@immutable
abstract class SurveyState {
}

/// SurveyInitial state.
class SurveyInitial extends SurveyState {
  @override
  String toString() => 'SurveyInitial';
}

/// SurveyLoading state.
class SurveyLoading extends SurveyState {
  @override
  String toString() => 'SurveyLoading';
}

/// SurveyFailure state.
class SurveyFailure extends SurveyState {
  SurveyFailure({@required this.error});

  final String error;

  @override
  String toString() => 'SurveyFailure { error: $error }';
}

/// LoadedSurvey state.
class LoadedSurvey extends SurveyState {
  LoadedSurvey(this.survey, { this.values, this.selectedSectionIndex = 0 });

  final Survey survey;
  final Map<Question, String> values;
  final int selectedSectionIndex;

  @override
  String toString() => 'LoadedSurvey';
}

/// LoadedSurvey state.
class SubmitSurveySuccess extends SurveyState {
  SubmitSurveySuccess();

  @override
  String toString() => 'SubmitSurveySuccess';
}
