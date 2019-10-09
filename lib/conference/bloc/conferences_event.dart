import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// Conference event.
@immutable
abstract class ConferencesEvent extends Equatable {
  const ConferencesEvent([List<dynamic> props = const <dynamic>[]]) : super(props);
}

/// LoadConferencesEvent event.
class LoadMoreConferencesEvent extends ConferencesEvent {
  @override
  String toString() => 'LoadConferencesEvent { }';
}

/// RefreshConferencesEvent event.
class RefreshConferencesEvent extends ConferencesEvent {
  @override
  String toString() => 'RefreshConferencesEvent { }';
}
