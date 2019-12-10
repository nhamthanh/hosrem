import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// Epub event.
@immutable
abstract class EpubEvent extends Equatable {
  const EpubEvent([List<dynamic> props = const <dynamic>[]]) : super(props);
}

/// LoadEpubEvent event.
class LoadEpubEvent extends EpubEvent {
  LoadEpubEvent(this.url) : super(<String>[url]);

  final String url;

  @override
  String toString() => 'LoadEpubEvent { }';
}
