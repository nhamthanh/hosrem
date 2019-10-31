import 'package:hosrem_app/api/conference/conference.dart';
import 'package:hosrem_app/api/payment/payment_type.dart';

/// Conference payment event.
abstract class ConferencePaymentEvent {}

/// LoadConferencePaymentDataEvent event.
class LoadConferencePaymentDataEvent extends ConferencePaymentEvent {
  LoadConferencePaymentDataEvent(this.conference, this.registrationFee, { this.selectedPaymentMethod });

  Conference conference;
  double registrationFee;
  String selectedPaymentMethod;

  @override
  String toString() => 'LoadConferencePaymentDataEvent { }';
}

/// ProcessMomoPaymentEvent event.
class ProcessMomoPaymentEvent extends ConferencePaymentEvent {
  ProcessMomoPaymentEvent(this.detail, this.conferenceId, this.fee, this.letterAddress,
      this.letterType, this.paymentType);

  final Map<String, dynamic> detail;
  final String conferenceId;
  final double fee;
  final String letterAddress;
  final String letterType;
  final PaymentType paymentType;

  @override
  String toString() => 'ProcessMomoPaymentEvent { }';
}

/// ChangePaymentMethodEvent event.
class ChangePaymentMethodEvent extends ConferencePaymentEvent {
  ChangePaymentMethodEvent(this.paymentTypes, this.registrationFee, this.premiumMembership,
    { this.selectedPaymentMethod });

  List<PaymentType> paymentTypes;
  double registrationFee;
  String selectedPaymentMethod;
  bool premiumMembership;

  @override
  String toString() => 'LoadConferencePaymentDataEvent { }';
}

/// ProcessCreditCardPaymentEvent event.
class ProcessCreditCardPaymentEvent extends ConferencePaymentEvent {
  ProcessCreditCardPaymentEvent(this.detail, this.conferenceId, this.fee, this.letterAddress,
    this.letterType, this.paymentType);

  final Map<String, dynamic> detail;
  final String conferenceId;
  final double fee;
  final String letterAddress;
  final String letterType;
  final PaymentType paymentType;

  @override
  String toString() => 'ProcessCreditCardPaymentEvent { }';
}

/// ProcessAtmPaymentEvent event.
class ProcessAtmPaymentEvent extends ConferencePaymentEvent {
  ProcessAtmPaymentEvent(this.detail, this.conferenceId, this.fee, this.letterAddress,
    this.letterType, this.paymentType);

  final Map<String, dynamic> detail;
  final String conferenceId;
  final double fee;
  final String letterAddress;
  final String letterType;
  final PaymentType paymentType;

  @override
  String toString() => 'ProcessAtmPaymentEvent { }';
}
