import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:hosrem_app/auth/auth_service.dart';
import 'package:hosrem_app/common/error_handler.dart';

import '../conference_service.dart';
import 'conference_registration_event.dart';
import 'conference_registration_state.dart';

/// Conference registration bloc to allow user to register the conference with payment gateway.
class ConferenceRegistrationBloc extends Bloc<ConferenceRegistrationEvent, ConferenceRegistrationState> {
  ConferenceRegistrationBloc({
    @required this.conferenceService,
    @required this.authService
  }) : assert(conferenceService != null), assert(authService != null);

  final ConferenceService conferenceService;
  final AuthService authService;

  @override
  ConferenceRegistrationState get initialState => ConferenceRegistrationLoading();

  @override
  Stream<ConferenceRegistrationState> mapEventToState(ConferenceRegistrationEvent event) async* {
    if (event is ConferenceRegistrationDataEvent) {
      try {
        final bool premiumMembership = await authService.isPremiumMembership();
        yield ConferenceRegistrationDataSuccess(premiumMembership,
          event.selectedConferenceFee ?? event.conferenceFees[0]);
      } catch (error) {
        yield ConferenceRegistrationFailure(error: ErrorHandler.extractErrorMessage(error));
      }
    }
  }
}
