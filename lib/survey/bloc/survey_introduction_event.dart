import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// Survey Introduction event.
@immutable
abstract class SurveyIntroductionEvent extends Equatable {
  const SurveyIntroductionEvent([List<String> props = const <String>[]]) : super(props);
}

/// LoadSurveyIntroduction event.
class LoadSurveyIntroduction extends SurveyIntroductionEvent {
  const LoadSurveyIntroduction(this.id);

  final String id;

  @override
  String toString() =>
      'LoadSurveyIntroduction { }';
}