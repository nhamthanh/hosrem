import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// Conference event.
@immutable
abstract class ConferencesEvent extends Equatable {
  const ConferencesEvent([List<dynamic> props = const <dynamic>[]]) : super(props);
}

/// LoadConferencesEvent event.
class LoadMoreConferencesEvent extends ConferencesEvent {
  LoadMoreConferencesEvent({
    @required this.searchCriteria,
  }) : super(<dynamic>[searchCriteria]);

  final Map<String, dynamic> searchCriteria;

  @override
  String toString() => 'LoadConferencesEvent { }';
}

/// RefreshConferencesEvent event.
class RefreshConferencesEvent extends ConferencesEvent {
  RefreshConferencesEvent({
    @required this.searchCriteria,
  }) : super(<dynamic>[searchCriteria]);

  final Map<String, dynamic> searchCriteria;

  @override
  String toString() => 'RefreshConferencesEvent { }';
}
