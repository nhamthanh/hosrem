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

/// LogoutConferenceEvent event.
class LogoutConferenceEvent extends DocumentsEvent {
  LogoutConferenceEvent(this.conference);
  final Conference conference;

  @override
  String toString() => 'LogoutConferenceEvent { }';
}
