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
    @required this.conferenceId, this.conferenceStatus
  }) : super(<String>[conferenceId, conferenceStatus]);

  final String conferenceId;
  final String conferenceStatus;
  @override
  String toString() => 'LoadConferenceFeesByConferenceIdEvent { }';
}
