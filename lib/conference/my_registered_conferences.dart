import 'package:flutter/material.dart';
import 'package:hosrem_app/auth/auth_service.dart';
import 'package:hosrem_app/common/base_state.dart';
import 'package:hosrem_app/connection/connection_provider.dart';
import 'package:hosrem_app/profile/user_service.dart';

import 'bloc/my_registered_conferences_bloc.dart';
import 'conference_service.dart';
import 'upcoming_conferences.dart';

/// My registered conferences page.
class MyRegisteredConferences extends StatefulWidget {
  @override
  State<MyRegisteredConferences> createState() => _MyRegisteredConferencesState();
}

class _MyRegisteredConferencesState extends BaseState<MyRegisteredConferences> {

  MyRegisteredConferencesBloc _myRegisteredConferencesBloc;

  @override
  void initState() {
    super.initState();

    final AuthService authService = AuthService(apiProvider);
    final UserService userService = UserService(apiProvider, authService);
    final ConferenceService conferenceService = ConferenceService(apiProvider);
    _myRegisteredConferencesBloc = MyRegisteredConferencesBloc(userService, conferenceService, authService);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hội Nghị Đã Đăng Ký'),
        centerTitle: true
      ),
      body: ConnectionProvider(
        child: UpcomingConferences(conferenceBloc: _myRegisteredConferencesBloc, criteria: const <String, dynamic>{})
      )
    );
  }
}
