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
  ConferenceUnlockState({ this.showLoginRegistration = false, this.unlocked = false });

  final bool unlocked;
  final bool showLoginRegistration;

  @override
  String toString() => 'ConferenceUnlockState';
}

/// LoadedDocumentsState state.
class LoadedDocumentsState extends DocumentsState {
  LoadedDocumentsState({ this.hasToken = false, this.documents = const <Document>[], this.supplementDocs = const <Document>[] });

  final List<Document> documents;
  final List<Document> supplementDocs;
  final bool hasToken;

  @override
  String toString() => 'LoadedDocumentsState';
}

