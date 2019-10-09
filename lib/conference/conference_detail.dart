import 'package:flutter/material.dart';
import 'package:hosrem_app/common/base_state.dart';

import 'conference_resources.dart';

/// Conference detail page.
class ConferenceDetail extends StatefulWidget {
  @override
  State<ConferenceDetail> createState() => _ConferenceDetailState();
}

class _ConferenceDetailState extends BaseState<ConferenceDetail> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event'),
        centerTitle: true
      ),
      body: ConferenceResources(),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
