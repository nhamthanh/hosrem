import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// Conference fees event.
@immutable
abstract class ConferenceFeesEvent extends Equatable {
  const ConferenceFeesEvent([List<String> props = const <String>[]]) : super(props);
}

/// LoadDocumentByConferenceIdEvent event.
class LoadConferenceFeesByConferenceIdEvent extends ConferenceFeesEvent {
  LoadConferenceFeesByConferenceIdEvent({
    @required this.conferenceId,
  }) : super(<String>[conferenceId]);

  final String conferenceId;

  @override
  String toString() => 'LoadConferenceFeesByConferenceIdEvent { }';
}
