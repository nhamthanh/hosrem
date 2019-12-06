import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// Conference event.
@immutable
abstract class ConferenceEvent extends Equatable {
  const ConferenceEvent([List<dynamic> props = const <String>[]]) : super(props);
}

/// LoadConferenceEvent event.
class LoadConferenceEvent extends ConferenceEvent {
  LoadConferenceEvent({@required this.conferenceId}) : super(<String>[conferenceId]);

  final String conferenceId;

  @override
  String toString() => 'LoadConferenceEvent { }';
}

/// Show conference detail event.
class ShowConferenceTabEvent extends ConferenceEvent {
  ShowConferenceTabEvent(this.conferenceId, { this.tabIndex = 0 }) : super(<dynamic>[conferenceId, tabIndex]);

  final String conferenceId;
  final int tabIndex;

  @override
  String toString() => 'ShowConferenceTabEvent { }';
}
