import 'package:hosrem_app/api/document/document.dart';
import 'package:meta/meta.dart';

/// Document state.
@immutable
abstract class DocumentsState {
}

/// DocumentsLoading state.
class DocumentsLoading extends DocumentsState {
  @override
  String toString() => 'DocumentsLoading';
}

/// DocumentsFailure state.
class DocumentsFailure extends DocumentsState {
  DocumentsFailure({@required this.error});

  final String error;

  @override
  String toString() => 'DocumentsFailure { error: $error }';
}

/// LoadedConferenceResources state.
class LoadedDocumentsState extends DocumentsState {
  LoadedDocumentsState({@required this.documents});

  final List<Document> documents;

  @override
  String toString() => 'LoadedDocumentsEvent';
}

