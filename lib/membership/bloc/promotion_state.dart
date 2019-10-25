import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// Promotion state.
@immutable
abstract class PromotionState extends Equatable {
  const PromotionState([List<dynamic> props = const <dynamic>[]]) : super(props);
}

/// PromotionLoading state.
class PromotionLoading extends PromotionState {
  @override
  String toString() => 'PromotionLoading';
}

/// PromotionFailure state.
class PromotionFailure extends PromotionState {
  PromotionFailure({@required this.error}) : super(<String>[error]);

  final String error;

  @override
  String toString() => 'PromotionFailure { error: $error }';
}

/// PromotionSuccess state.
class PromotionSuccess extends PromotionState {
  PromotionSuccess({@required this.message}) : super(<String>[message]);

  final String message;

  @override
  String toString() => 'PromotionSuccess';
}
