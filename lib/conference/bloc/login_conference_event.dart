import 'package:hosrem_app/api/conference/conference.dart';
import 'package:meta/meta.dart';

/// Login conference event.
@immutable
abstract class LoginConferenceEvent {}

/// LoginConferencePressedEvent event.
class LoginConferencePressedEvent extends LoginConferenceEvent {
  LoginConferencePressedEvent({
    @required this.fullName,
    @required this.registrationCode,
    @required this.conference
  });

  final String fullName;
  final String registrationCode;
  final Conference conference;

  @override
  String toString() => 'LoginConferencePressedEvent { }';
}

/// ValidateFormFieldEvent event.
class ValidateFormFieldEvent extends LoginConferenceEvent {
  ValidateFormFieldEvent({
    @required this.name,
    @required this.value
  });

  final String name;
  final String value;

  @override
  String toString() => 'ValidateFormFieldEvent { name = $name, value = $value }';
}
