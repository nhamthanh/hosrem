import 'package:equatable/equatable.dart';
import 'package:hosrem_app/api/conference/conference.dart';
import 'package:meta/meta.dart';

/// Documents event.
@immutable
abstract class DocumentsEvent extends Equatable {
  const DocumentsEvent([List<dynamic> props = const <dynamic>[]]) : super(props);
}

/// LoadDocumentByConferenceIdEvent event.
class LoadDocumentByConferenceIdEvent extends DocumentsEvent {
  LoadDocumentByConferenceIdEvent({
    @required this.conference,
    @required this.supplementDocs,
  }) : super(<Conference>[conference]);

  final Conference conference;
  final List<String> supplementDocs;

  @override
  String toString() => 'LoadDocumentByConferenceIdEvent { }';
}

/// FilterDocumentsEvent event.
class FilterDocumentsEvent extends DocumentsEvent {
  FilterDocumentsEvent({
    @required this.filterText
  }) : super(<String>[filterText]);

  final String filterText;

  @override
  String toString() => 'FilterDocumentsEvent { }';
}
