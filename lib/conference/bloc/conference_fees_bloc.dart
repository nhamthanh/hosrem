import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:hosrem_app/api/auth/user.dart';
import 'package:hosrem_app/api/conference/conference_auth.dart';
import 'package:hosrem_app/api/conference/conference_fee.dart';
import 'package:hosrem_app/api/conference/conference_fees.dart';
import 'package:hosrem_app/api/conference/conference_registration.dart';
import 'package:hosrem_app/api/conference/user_conference.dart';
import 'package:hosrem_app/auth/auth_service.dart';
import 'package:hosrem_app/common/error_handler.dart';
import 'package:hosrem_app/profile/user_service.dart';
import 'package:logging/logging.dart';

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
  final Logger _logger = Logger('ConferenceFeesBloc');

  @override
  ConferenceFeesState get initialState => ConferenceFeesLoading();

  @override
  Stream<ConferenceFeesState> mapEventToState(ConferenceFeesEvent event) async* {
    if (event is LoadConferenceFeesByConferenceIdEvent) {
      String registrationCode = '';
      String surveyResultId = '';
      try {
        final bool premiumMembership = await authService.isPremiumMembership();
        final User user = await authService.currentUser();
        final ConferenceFees conferenceFees = await conferenceService.getConferenceFees(event.conferenceId);
        final ConferenceAuth conferenceAuth = await authService.getConferenceAuth(event.conferenceId);
        final bool registeredConference =
            user != null ? await conferenceService.checkIfUserRegisterConference(event.conferenceId, user.id)
                     :  conferenceAuth != null;

        final List<ConferenceFee> selectedConferenceFees = _filterConferenceFeesByNowAndMembership(premiumMembership,
            conferenceFees);
        final bool allowRegistration = event.conferenceStatus != 'Done'
          ? selectedConferenceFees.any((ConferenceFee conferenceFee) => conferenceFee.onlineRegistration)
          : false;


        bool showLoginRegistration = conferenceAuth == null;
        if (user != null) {
          showLoginRegistration = false;
          final UserConference userConference = await userService.getSpecificRegisteredConference(event.conferenceId);
          if (userConference != null) {
            registrationCode = userConference.registrationCode;
            surveyResultId = userConference.surveyResultId ?? '';
            showLoginRegistration = userConference.status != 'Confirmed';
          }
        } else if (conferenceAuth != null) {
          final ConferenceRegistration conferenceRegistration =
              await conferenceService.getRegistrationInfoFromRegCode(event.conferenceId, conferenceAuth.regCode);
          surveyResultId = conferenceRegistration.surveyResultId ?? '';
        }
        yield LoadedConferenceFees(
          conferenceFees,
          selectedConferenceFees,
          allowRegistration: allowRegistration,
          registeredConference: registeredConference,
          showLoginRegistration: showLoginRegistration,
          registrationCode: registrationCode,
          surveyResultId: surveyResultId,
          hasToken: user != null
        );
      } catch (error) {
        _logger.fine(error);
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
