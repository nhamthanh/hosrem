import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// Survey Introduction event.
@immutable
abstract class SurveyIntroductionEvent extends Equatable {
  const SurveyIntroductionEvent([List<String> props = const <String>[]]) : super(props);
}

/// LoadSurveyIntroduction event.
class LoadSurveyIntroduction extends SurveyIntroductionEvent {
  const LoadSurveyIntroduction(this.conferenceId, { this.surveyResultId = '' });

  final String conferenceId;

  final String surveyResultId;

  @override
  String toString() =>
      'LoadSurveyIntroduction { }';
}