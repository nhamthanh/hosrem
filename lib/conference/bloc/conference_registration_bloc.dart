import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';

import '../conference_service.dart';
import 'conference_registration_event.dart';
import 'conference_registration_state.dart';

/// Conference registration bloc to allow user to register the conference with payment gateway.
class ConferenceRegistrationBloc extends Bloc<ConferenceRegistrationEvent, ConferenceRegistrationState> {
  ConferenceRegistrationBloc({@required this.conferenceService}) :
      assert(conferenceService != null);

  final ConferenceService conferenceService;

  @override
  ConferenceRegistrationState get initialState => ConferenceRegistrationLoading();

  @override
  Stream<ConferenceRegistrationState> mapEventToState(ConferenceRegistrationEvent event) async* {
  }
}
