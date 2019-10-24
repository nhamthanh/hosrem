import 'dart:async';

import 'package:bloc/bloc.dart';

import 'membership_payment_event.dart';
import 'membership_payment_state.dart';
import 'promotion_event.dart';
import 'promotion_state.dart';

/// Membership payment bloc process payment via payment gateways.
class MembershipPaymentBloc extends Bloc<MembershipPaymentEvent, MembershipPaymentState> {
  @override
  MembershipPaymentState get initialState => MembershipPaymentLoading();

  @override
  Stream<MembershipPaymentState> mapEventToState(MembershipPaymentEvent event) async* {
    if (event is MomoPaymentEvent) {
      await Future<void>.delayed(Duration(seconds: 1));
      yield MembershipPaymentSuccess();
    }
  }
}
