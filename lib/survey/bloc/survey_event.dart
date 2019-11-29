import 'package:hosrem_app/api/survey/question.dart';
import 'package:meta/meta.dart';

/// Survey event.
@immutable
abstract class SurveyEvent {
}

/// LoadSurveyEvent event.
class LoadSurveyEvent extends SurveyEvent {
  LoadSurveyEvent(this.conferenceId, { this.surveyResultId = '' });

  final String conferenceId;

  final String surveyResultId;

  @override
  String toString() => 'LoadSurveyEvent { conferenceId = $conferenceId, surveyResultId = $surveyResultId }';
}

/// RatingEvent event.
class RatingEvent extends SurveyEvent {
  RatingEvent(this.question, this.value);

  final Question question;
  final String value;

  @override
  String toString() => 'RatingEvent {}';
}

/// RatingEvent event.
class ChangeSectionEvent extends SurveyEvent {
  ChangeSectionEvent(this.sectionIndex);

  final int sectionIndex;

  @override
  String toString() => 'ChangeSectionEvent {}';
}

/// Submit rating result event.
class SubmitRatingEvent extends SurveyEvent {
  SubmitRatingEvent(this.values, this.conferenceId, { this.surveyResultId = '' });

  final Map<Question, String> values;
  final String conferenceId;
  final String surveyResultId;

  @override
  String toString() => 'SubmitRatingEvent {}';
}
