import 'package:flutter/widgets.dart';
import 'package:hosrem_app/api/payment/payment_type.dart';

/// Conference payment state.
@immutable
abstract class ConferencePaymentState {
}

/// ConferencePaymentLoading state.
class ConferencePaymentLoading extends ConferencePaymentState {
  @override
  String toString() => 'ConferencePaymentLoading';
}

/// ConferencePaymentFailure state.
class ConferencePaymentFailure extends ConferencePaymentState {
  ConferencePaymentFailure({@required this.error});

  final String error;

  @override
  String toString() => 'ConferencePaymentFailure { error: $error }';
}

/// ConferencePaymentSuccess state.
class ConferencePaymentSuccess extends ConferencePaymentState {
  @override
  String toString() => 'ConferencePaymentSuccess';
}

/// ConferencePaymentDataSuccess state.
class ConferencePaymentDataSuccess extends ConferencePaymentState {
  ConferencePaymentDataSuccess(this.paymentTypes, this.premiumMembership, this.registrationFee,
      { this.selectedPaymentMethod });

  final List<PaymentType> paymentTypes;
  final String selectedPaymentMethod;
  final bool premiumMembership;
  final double registrationFee;

  @override
  String toString() => 'ConferencePaymentDataSuccess {}';
}
