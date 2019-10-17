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

/// LoadedDocumentsState state.
class LoadedDocumentsState extends DocumentsState {
  LoadedDocumentsState({@required this.documents, @required this.supplementDocs, @required this.token});

  final List<Document> documents;
  final List<Document> supplementDocs;
  final String token;

  @override
  String toString() => 'LoadedDocumentsState';
}

