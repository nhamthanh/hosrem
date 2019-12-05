import 'package:epub/epub.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// Epub state.
@immutable
abstract class EpubState extends Equatable {
  const EpubState([List<dynamic> props = const <dynamic>[]]) : super(props);
}

/// EpubLoading state.
class EpubLoading extends EpubState {
  @override
  String toString() => 'EpubLoading';
}

/// EpubFailure state.
class EpubFailure extends EpubState {
  EpubFailure({@required this.error}) : super(<String>[error]);

  final String error;

  @override
  String toString() => 'EpubFailure { error: $error }';
}

/// LoadedEpub state.
class LoadedEpub extends EpubState {
  LoadedEpub({@required this.epubBook}) : super(<EpubBook>[epubBook]);

  final EpubBook epubBook;

  @override
  String toString() => 'LoadedEpub';
}
