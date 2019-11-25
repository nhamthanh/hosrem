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

/// DefaultDocumentsState state.
class ConferenceUnlockState extends DocumentsState {
  ConferenceUnlockState({ @required this.fields, this.loggedIn = false, this.unlocked = false,
    this.loading = false, this.errorMsg = '' });

  final bool unlocked;
  final bool loggedIn;
  final bool loading;
  final String errorMsg;
  final Map<String, bool> fields;

  @override
  String toString() => 'ConferenceUnlockState';
}

/// LoadedDocumentsState state.
class LoadedDocumentsState extends DocumentsState {
  LoadedDocumentsState({ this.documents = const <Document>[], this.supplementDocs = const <Document>[] });

  final List<Document> documents;
  final List<Document> supplementDocs;

  @override
  String toString() => 'LoadedDocumentsState';
}

