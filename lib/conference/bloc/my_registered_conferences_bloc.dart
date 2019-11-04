import 'dart:async';

import 'package:hosrem_app/api/conference/conference_pagination.dart';
import 'package:hosrem_app/api/conference/user_conference.dart';
import 'package:hosrem_app/api/conference/user_conference_pagination.dart';
import 'package:hosrem_app/auth/auth_service.dart';
import 'package:hosrem_app/profile/user_service.dart';

import '../conference_service.dart';
import 'conferences_bloc.dart';

/// My registered conference bloc to load conferences.
class MyRegisteredConferencesBloc extends ConferencesBloc {
  MyRegisteredConferencesBloc(this.userService, ConferenceService conferenceService, AuthService authService) :
      super(conferenceService: conferenceService, authService: authService);

  final UserService userService;

  @override
  Future<ConferencePagination> queryConferences(Map<String, dynamic> queryParams) async {
    final UserConferencePagination userConferencePagination = await userService.getRegisteredConferences(queryParams);
    return ConferencePagination(
      userConferencePagination.totalItems,
      userConferencePagination.page,
      userConferencePagination.totalPages,
      userConferencePagination.size,
      userConferencePagination.items.map((UserConference userConference) => userConference.conference).toList()
    );
  }
}
