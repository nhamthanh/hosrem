import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:hosrem_app/api/auth/user.dart';
import 'package:hosrem_app/api/conference/conference_fee.dart';
import 'package:hosrem_app/api/conference/conference_fees.dart';
import 'package:hosrem_app/api/conference/user_conference.dart';
import 'package:hosrem_app/auth/auth_service.dart';
import 'package:hosrem_app/common/error_handler.dart';
import 'package:hosrem_app/profile/user_service.dart';

import '../conference_service.dart';
import 'conference_fees_event.dart';
import 'conference_fees_state.dart';

/// Conference fees bloc.
class ConferenceFeesBloc extends Bloc<ConferenceFeesEvent, ConferenceFeesState> {
  ConferenceFeesBloc({@required this.conferenceService, @required this.authService, @required this.userService}) :
      assert(conferenceService != null), assert(authService != null);

  static const int DEFAULT_PAGE = 0;
  static const int DEFAULT_PAGE_SIZE = 1000;
  final UserService userService;
  final ConferenceService conferenceService;
  final AuthService authService;

  @override
  ConferenceFeesState get initialState => ConferenceFeesLoading();

  @override
  Stream<ConferenceFeesState> mapEventToState(ConferenceFeesEvent event) async* {
    if (event is LoadConferenceFeesByConferenceIdEvent) {
      String registrationCode = '';
      try {
        final bool premiumMembership = await authService.isPremiumMembership();
        final bool hasToken = await authService.hasToken();
        final User user = await authService.currentUser();
        final ConferenceFees conferenceFees = await conferenceService.getConferenceFees(event.conferenceId);
        final bool registeredConference =
            hasToken ? await conferenceService.checkIfUserRegisterConference(event.conferenceId, user.id) : false;
        final List<ConferenceFee> selectedConferenceFees = _filterConferenceFeesByNowAndMembership(premiumMembership,
            conferenceFees);
        final bool allowRegistration = selectedConferenceFees.any((ConferenceFee conferenceFee) => conferenceFee.onlineRegistration);
        if (authService.currentUser() != null) {
          final UserConference userConference = await userService.getSpecificRegisteredConference(event.conferenceId);
          if (userConference != null) {
            registrationCode = userConference.registrationCode;
          }
        }
        yield LoadedConferenceFees(conferenceFees, selectedConferenceFees,
            allowRegistration: allowRegistration, registeredConference: registeredConference, hasToken: hasToken, registrationCode: registrationCode);
      } catch (error) {
        yield ConferenceFeesFailure(error: ErrorHandler.extractErrorMessage(error));
      }
    }
  }

  List<ConferenceFee> _filterConferenceFeesByNowAndMembership(bool premiumMembership, ConferenceFees conferenceFees) {
    if (premiumMembership) {
      return _filterConferenceFeesByNow(conferenceFees.memberFees);
    }

    return _filterConferenceFeesByNow(conferenceFees.otherFees);
  }

  List<ConferenceFee> _filterConferenceFeesByNow(List<ConferenceFee> conferenceFees) {
    final DateTime now = DateTime.now();
    final DateTime beginOfDay = DateTime(now.year, now.month, now.day, 0, 0, 0);
    final Map<DateTime, List<ConferenceFee>> groupByMilestoneFees =
        groupBy(conferenceFees, (ConferenceFee conferenceFee) => conferenceFee.milestone);
    final ConferenceFee conferenceFee = conferenceFees.firstWhere(
        (ConferenceFee conferenceFee) => !beginOfDay.isAfter(conferenceFee.milestone), orElse: () => null);
    return conferenceFee == null ? <ConferenceFee>[] : groupByMilestoneFees[conferenceFee.milestone];
  }
}
