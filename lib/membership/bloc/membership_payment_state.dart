import 'package:equatable/equatable.dart';
import 'package:hosrem_app/api/payment/payment.dart';
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
  LoadedPaymentData({@required this.paymentTypes, this.selectedPayment}) :
      super(<dynamic>[paymentTypes, selectedPayment]);

  final List<PaymentType> paymentTypes;
  final String selectedPayment;

  @override
  String toString() => 'LoadedPaymentData';
}

/// MembershipCreditCardPaymentSuccess state.
@immutable
class MembershipCreditCardPaymentSuccess extends MembershipPaymentState {
  const MembershipCreditCardPaymentSuccess(this.payment);

  final Payment payment;

  @override
  String toString() => 'MembershipCreditCardPaymentSuccess';
}


/// MembershipAtmPaymentSuccess state.
@immutable
class MembershipAtmPaymentSuccess extends MembershipPaymentState {
  const MembershipAtmPaymentSuccess(this.payment);

  final Payment payment;

  @override
  String toString() => 'MembershipAtmPaymentSuccess';
}
