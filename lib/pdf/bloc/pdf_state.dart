import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// Pdf state.
@immutable
abstract class PdfState extends Equatable {
  const PdfState([List<dynamic> props = const <dynamic>[]]) : super(props);
}

/// PdfLoading state.
class PdfLoading extends PdfState {
  @override
  String toString() => 'PdfLoading';
}

/// PdfFailure state.
class PdfFailure extends PdfState {
  PdfFailure({@required this.error}) : super(<String>[error]);

  final String error;

  @override
  String toString() => 'PdfFailure { error: $error }';
}

/// LoadedPdf state.
class LoadedPdf extends PdfState {
  LoadedPdf({@required this.path}) : super(<String>[path]);

  final String path;

  @override
  String toString() => 'LoadedPdf';
}
