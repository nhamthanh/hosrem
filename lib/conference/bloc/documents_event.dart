import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// Documents event.
@immutable
abstract class DocumentsEvent extends Equatable {
  const DocumentsEvent([List<String> props = const <String>[]]) : super(props);
}

/// LoadDocumentByConferenceIdEvent event.
class LoadDocumentByConferenceIdEvent extends DocumentsEvent {
  LoadDocumentByConferenceIdEvent({
    @required this.conferenceId,
    @required this.supplementDocs,
  }) : super(<String>[conferenceId]);

  final String conferenceId;
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
