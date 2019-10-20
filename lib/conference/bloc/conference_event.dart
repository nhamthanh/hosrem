import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// Conference event.
@immutable
abstract class ConferenceEvent extends Equatable {
  const ConferenceEvent([List<String> props = const <String>[]]) : super(props);
}

/// LoadConferenceEvent event.
class LoadConferenceEvent extends ConferenceEvent {
  LoadConferenceEvent({@required this.conferenceId}) : super(<String>[conferenceId]);

  final String conferenceId;

  @override
  String toString() => 'LoadConferenceEvent { }';
}
