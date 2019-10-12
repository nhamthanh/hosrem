import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// Pdf event.
@immutable
abstract class PdfEvent extends Equatable {
  const PdfEvent([List<dynamic> props = const <dynamic>[]]) : super(props);
}

/// LoadPdfEvent event.
class LoadPdfEvent extends PdfEvent {
  LoadPdfEvent(this.url) : super(<String>[url]);

  final String url;

  @override
  String toString() => 'LoadPdfEvent { }';
}
