import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hosrem_app/api/payment/payment_type.dart';
import 'package:hosrem_app/auth/auth_service.dart';
import 'package:hosrem_app/common/error_handler.dart';
import 'package:hosrem_app/membership/payment_service.dart';

import '../conference_service.dart';
import 'conference_payment_event.dart';
import 'conference_payment_state.dart';

/// Conference payment bloc to handle / charge conference's via payment gateway.
class ConferencePaymentBloc extends Bloc<ConferencePaymentEvent, ConferencePaymentState> {
  ConferencePaymentBloc(this.conferenceService, this.authService, this.paymentService);

  final ConferenceService conferenceService;
  final AuthService authService;
  final PaymentService paymentService;

  @override
  ConferencePaymentState get initialState => ConferencePaymentLoading();

  @override
  Stream<ConferencePaymentState> mapEventToState(ConferencePaymentEvent event) async* {
    if (event is LoadConferencePaymentDataEvent) {
      try {
        final bool premiumMembership = await authService.isPremiumMembership();
        final List<PaymentType> paymentTypes = await paymentService.getPaymentTypes();
        yield ConferencePaymentDataSuccess(paymentTypes, premiumMembership, event.registrationFee,
          selectedPaymentMethod: event.selectedPaymentMethod
        );
      } catch (error) {
        yield ConferencePaymentFailure(error: ErrorHandler.extractErrorMessage(error));
      }
    }

    if (event is ProcessMomoPaymentEvent) {
      yield ConferencePaymentLoading();
      try {
        yield ConferencePaymentSuccess();
      } catch (error) {
        yield ConferencePaymentFailure(error: ErrorHandler.extractErrorMessage(error));
      }
    }

    if (event is ChangePaymentMethodEvent) {
      try {
        yield ConferencePaymentDataSuccess(event.paymentTypes, event.premiumMembership, event.registrationFee,
          selectedPaymentMethod: event.selectedPaymentMethod
        );
      } catch (error) {
        yield ConferencePaymentFailure(error: ErrorHandler.extractErrorMessage(error));
      }
    }
  }
}