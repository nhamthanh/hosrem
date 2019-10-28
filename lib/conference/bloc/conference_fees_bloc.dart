import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:hosrem_app/api/conference/conference_fee.dart';
import 'package:hosrem_app/api/conference/conference_fees.dart';
import 'package:hosrem_app/auth/auth_service.dart';
import 'package:hosrem_app/common/error_handler.dart';

import '../conference_service.dart';
import 'conference_fees_event.dart';
import 'conference_fees_state.dart';

/// Conference fees bloc.
class ConferenceFeesBloc extends Bloc<ConferenceFeesEvent, ConferenceFeesState> {
  ConferenceFeesBloc({@required this.conferenceService, @required this.authService}) :
      assert(conferenceService != null), assert(authService != null);

  static const int DEFAULT_PAGE = 0;
  static const int DEFAULT_PAGE_SIZE = 1000;

  final ConferenceService conferenceService;
  final AuthService authService;

  @override
  ConferenceFeesState get initialState => ConferenceFeesLoading();

  @override
  Stream<ConferenceFeesState> mapEventToState(ConferenceFeesEvent event) async* {
    if (event is LoadConferenceFeesByConferenceIdEvent) {
      try {
        final bool premiumMembership = await authService.isPremiumMembership();
        final ConferenceFees conferenceFees = await conferenceService.getConferenceFees(event.conferenceId);
        final List<ConferenceFee> selectedConferenceFees = _filterConferenceFeesByNowAndMembership(premiumMembership,
            conferenceFees);
        final bool allowRegistration = selectedConferenceFees.any((ConferenceFee conferenceFee) => conferenceFee.onlineRegistration);
        yield LoadedConferenceFees(conferenceFees, selectedConferenceFees, allowRegistration: allowRegistration);
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
    final Map<DateTime, List<ConferenceFee>> groupByMilestoneFees =
        groupBy(conferenceFees, (ConferenceFee conferenceFee) => conferenceFee.milestone);
    final ConferenceFee conferenceFee = conferenceFees.firstWhere(
        (ConferenceFee conferenceFee) => now.isBefore(conferenceFee.milestone), orElse: () => null);
    return conferenceFee == null ? <ConferenceFee>[] : groupByMilestoneFees[conferenceFee.milestone];
  }
}
