import 'package:meta/meta.dart';

/// Surveys event.
@immutable
abstract class SurveysEvent {
}

/// LoadSurveysEvent event.
class LoadSurveysEvent extends SurveysEvent {
  @override
  String toString() => 'LoadSurveysEvent { }';
}
