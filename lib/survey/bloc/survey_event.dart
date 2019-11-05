import 'package:hosrem_app/api/survey/question.dart';
import 'package:meta/meta.dart';

/// Survey event.
@immutable
abstract class SurveyEvent {
}

/// LoadSurveyEvent event.
class LoadSurveyEvent extends SurveyEvent {
  LoadSurveyEvent(this.id);

  final String id;

  @override
  String toString() => 'LoadSurveyEvent { id = $id }';
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
