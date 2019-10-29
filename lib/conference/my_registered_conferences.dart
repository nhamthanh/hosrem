import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosrem_app/api/conference/conference.dart';
import 'package:hosrem_app/auth/auth_service.dart';
import 'package:hosrem_app/common/base_state.dart';
import 'package:hosrem_app/loading/loading_indicator.dart';
import 'package:hosrem_app/widget/refresher/refresh_widget.dart';
import 'package:hosrem_app/widget/text/search_text_field.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'bloc/conferences_bloc.dart';
import 'bloc/conferences_event.dart';
import 'bloc/conferences_state.dart';
import 'conference_detail.dart';
import 'conference_item.dart';
import 'conference_service.dart';
import 'upcoming_conferences.dart';

/// My registered conferences page.
class MyRegisteredConferences extends StatefulWidget {
  @override
  State<MyRegisteredConferences> createState() => _MyRegisteredConferencesState();
}

class _MyRegisteredConferencesState extends BaseState<MyRegisteredConferences> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hội Nghị Đã Đăng Ký'),
        centerTitle: true
      ),
      body: const UpcomingConferences(criteria: <String, dynamic>{
        'status': 'Published',
        'sort': 'startTime:asc'
      }),
    );
  }
}
