import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// Promotion event.
@immutable
abstract class PromotionEvent extends Equatable {
  const PromotionEvent([List<dynamic> props = const <dynamic>[]]) : super(props);
}

/// PromotionValidation event.
class PromotionValidationEvent extends PromotionEvent {
  PromotionValidationEvent({@required this.promotionCode}) : super(<String>[promotionCode]);

  final String promotionCode;

  @override
  String toString() => 'PromotionValidationEvent { }';
}
