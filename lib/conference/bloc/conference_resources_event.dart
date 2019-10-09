import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// Conference resources event.
@immutable
abstract class ConferenceResourcesEvent extends Equatable {
  const ConferenceResourcesEvent([List<dynamic> props = const <dynamic>[]]) : super(props);
}

/// LoadMoreConferenceResourcesEvent event.
class LoadMoreConferenceResourcesEvent extends ConferenceResourcesEvent {
  @override
  String toString() => 'LoadMoreConferenceResourcesEvent { }';
}

/// RefreshConferenceResourcesEvent event.
class RefreshConferenceResourcesEvent extends ConferenceResourcesEvent {
  @override
  String toString() => 'RefreshConferenceResourcesEvent { }';
}
