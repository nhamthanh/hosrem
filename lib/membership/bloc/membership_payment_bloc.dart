import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:hosrem_app/api/payment/payment.dart';
import 'package:hosrem_app/common/error_handler.dart';

import '../payment_service.dart';
import 'membership_payment_event.dart';
import 'membership_payment_state.dart';

/// Membership payment bloc process payment via payment gateways.
class MembershipPaymentBloc extends Bloc<MembershipPaymentEvent, MembershipPaymentState> {
  MembershipPaymentBloc({
    @required this.paymentService
  })  : assert(paymentService != null);

  final PaymentService paymentService;

  @override
  MembershipPaymentState get initialState => MembershipPaymentLoading();

  @override
  Stream<MembershipPaymentState> mapEventToState(MembershipPaymentEvent event) async* {
    if (event is ProcessMomoPaymentEvent) {
      yield MembershipPaymentLoading();
      try {
        await paymentService.createPayment(event.membership, event.paymentType, event.detail);
        yield MembershipPaymentSuccess();
      } catch (error) {
        yield MembershipPaymentFailure(error: ErrorHandler.extractErrorMessage(error));
      }
    }

    if (event is LoadPaymentDataEvent) {
      yield MembershipPaymentLoading();
      try {
        yield LoadedPaymentData(paymentTypes: await paymentService.getPaymentTypes());
      } catch (error) {
        yield MembershipPaymentFailure(error: ErrorHandler.extractErrorMessage(error));
      }
    }

    if (event is ChangePaymentMethodEvent) {
      try {
        yield LoadedPaymentData(paymentTypes: event.paymentTypes, selectedPayment: event.selectedPayment);
      } catch (error) {
        yield MembershipPaymentFailure(error: ErrorHandler.extractErrorMessage(error));
      }
    }

    if (event is ProcessCreditCardPaymentEvent) {
      yield MembershipPaymentLoading();
      try {
        final Payment payment = await paymentService.createPayment(event.membership, event.paymentType, event.detail);
        yield MembershipCreditCardPaymentSuccess(payment);
      } catch (error) {
        yield MembershipPaymentFailure(error: ErrorHandler.extractErrorMessage(error));
      }
    }

    if (event is ProcessAtmPaymentEvent) {
      yield MembershipPaymentLoading();
      try {
        final Payment payment = await paymentService.createPayment(event.membership, event.paymentType, event.detail);
        yield MembershipAtmPaymentSuccess(payment);
      } catch (error) {
        yield MembershipPaymentFailure(error: ErrorHandler.extractErrorMessage(error));
      }
    }
  }
}
