import 'package:flutter/material.dart';
import 'package:hosrem_app/common/base_state.dart';

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
