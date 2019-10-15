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
  }) : super(<String>[conferenceId]);

  final String conferenceId;

  @override
  String toString() => 'LoadDocumentByConferenceIdEvent { }';
}
