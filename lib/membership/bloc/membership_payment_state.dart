import 'package:equatable/equatable.dart';
import 'package:hosrem_app/api/payment/payment_type.dart';
import 'package:meta/meta.dart';

/// Membership payment state.
@immutable
abstract class MembershipPaymentState extends Equatable {
  const MembershipPaymentState([List<dynamic> props = const <dynamic>[]]) : super(props);
}

/// MembershipPaymentLoading state.
class MembershipPaymentLoading extends MembershipPaymentState {
  @override
  String toString() => 'MembershipPaymentLoading';
}

/// MembershipPaymentFailure state.
class MembershipPaymentFailure extends MembershipPaymentState {
  MembershipPaymentFailure({@required this.error}) : super(<String>[error]);

  final String error;

  @override
  String toString() => 'MembershipPaymentFailure { error: $error }';
}

/// MembershipPaymentSuccess state.
class MembershipPaymentSuccess extends MembershipPaymentState {
  @override
  String toString() => 'MembershipPaymentSuccess';
}

/// LoadedPaymentData state.
class LoadedPaymentData extends MembershipPaymentState {
  LoadedPaymentData({@required this.paymentTypes}) : super(<dynamic>[paymentTypes]);

  final List<PaymentType> paymentTypes;

  @override
  String toString() => 'LoadedPaymentData';
}
