import 'package:meta/meta.dart';

/// Surveys state.
@immutable
abstract class SurveysState {
}

/// SurveysInitial state.
class SurveysInitial extends SurveysState {
  @override
  String toString() => 'SurveysInitial';
}

/// SurveysLoading state.
class SurveysLoading extends SurveysState {
  @override
  String toString() => 'SurveysLoading';
}

/// SurveysFailure state.
class SurveysFailure extends SurveysState {
  SurveysFailure({@required this.error});

  final String error;

  @override
  String toString() => 'SurveysFailure { error: $error }';
}

/// LoadedSurveys state.
class LoadedSurveys extends SurveysState {
  @override
  String toString() => 'LoadedSurveys';
}
