import 'package:hosrem_app/api/conference/conference.dart';
import 'package:meta/meta.dart';

/// Documents event.
@immutable
abstract class DocumentsEvent {}

/// CheckIfUnlockConferenceEvent event.
class CheckIfUnlockConferenceEvent extends DocumentsEvent {
  CheckIfUnlockConferenceEvent(this.conference);

  final Conference conference;

  @override
  String toString() => 'CheckIfUnlockConferenceEvent { }';
}

/// LoadDocumentByConferenceIdEvent event.
class LoadDocumentByConferenceIdEvent extends DocumentsEvent {
  LoadDocumentByConferenceIdEvent(this.conference, this.supplementDocs);

  final Conference conference;
  final List<String> supplementDocs;

  @override
  String toString() => 'LoadDocumentByConferenceIdEvent { }';
}

/// FilterDocumentsEvent event.
class FilterDocumentsEvent extends DocumentsEvent {
  FilterDocumentsEvent({
    @required this.filterText
  });

  final String filterText;

  @override
  String toString() => 'FilterDocumentsEvent { }';
}

/// ViewDocumentsPressedEvent event.
class ViewDocumentsPressedEvent extends DocumentsEvent {
  ViewDocumentsPressedEvent({
    @required this.fullName,
    @required this.registrationCode,
    @required this.conference,
    @required this.supplementDocs
  });

  final String fullName;
  final String registrationCode;
  final Conference conference;
  final List<String> supplementDocs;

  @override
  String toString() => 'ViewDocumentsPressedEvent { }';
}

/// ValidateFormFieldEvent event.
class ValidateFormFieldEvent extends DocumentsEvent {
  ValidateFormFieldEvent({
    @required this.name,
    @required this.value
  });

  final String name;
  final String value;

  @override
  String toString() => 'ValidateFormFieldEvent { name = $name, value = $value }';
}
