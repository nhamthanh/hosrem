import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hosrem_app/api/membership/membership_pagination.dart';
import 'package:hosrem_app/common/error_handler.dart';
import 'package:meta/meta.dart';

import '../membership_service.dart';
import 'membership_event.dart';
import 'membership_state.dart';

/// Membership bloc to load membership types.
class MembershipBloc extends Bloc<MembershipEvent, MembershipState> {
  MembershipBloc({
    @required this.membershipService
  })  : assert(membershipService != null);

  final MembershipService membershipService;

  @override
  MembershipState get initialState => MembershipInitial();

  @override
  Stream<MembershipState> mapEventToState(MembershipEvent event) async* {
    if (event is LoadMembershipEvent) {
      yield MembershipLoading();

      try {
        final MembershipPagination membershipPagination = await membershipService.getMemberships();
        yield MembershipSuccess(memberships: membershipPagination.items);
      } catch (error) {
        yield MembershipFailure(error: ErrorHandler.extractErrorMessage(error));
      }
    }

    if (event is SelectMembershipEvent) {
      try {
        yield MembershipSuccess(memberships: event.memberships, selectedMembership: event.selectedMembership);
      } catch (error) {
        yield MembershipFailure(error: ErrorHandler.extractErrorMessage(error));
      }
    }
  }
}
