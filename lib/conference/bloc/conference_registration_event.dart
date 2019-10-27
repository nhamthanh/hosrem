import 'package:hosrem_app/api/conference/conference.dart';
import 'package:hosrem_app/api/conference/conference_fee.dart';

/// Conference registration event.
abstract class ConferenceRegistrationEvent {}

/// RefreshConferencesEvent event.
class ConferenceRegistrationDataEvent extends ConferenceRegistrationEvent {
  ConferenceRegistrationDataEvent(this.conference, this.conferenceFees, { this.selectedConferenceFee });

  List<ConferenceFee> conferenceFees;
  Conference conference;
  ConferenceFee selectedConferenceFee;

  @override
  String toString() => 'ConferenceRegistrationDataEvent { }';
}
