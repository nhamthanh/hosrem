import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosrem_app/common/base_state.dart';
import 'package:hosrem_app/conference/bloc/conference_registration_bloc.dart';
import 'package:hosrem_app/conference/bloc/conference_registration_state.dart';
import 'package:hosrem_app/loading/loading_indicator.dart';

import '../conference_service.dart';

/// Conference registration page.
@immutable
class ConferenceRegistration extends StatefulWidget {
  @override
  _ConferenceRegistrationState createState() => _ConferenceRegistrationState();
}

class _ConferenceRegistrationState extends BaseState<ConferenceRegistration> {

  ConferenceRegistrationBloc _conferenceRegistrationBloc;

  @override
  void initState() {
    super.initState();

    _conferenceRegistrationBloc = ConferenceRegistrationBloc(conferenceService: ConferenceService(apiProvider));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConferenceRegistrationBloc, ConferenceRegistrationState>(
      bloc: _conferenceRegistrationBloc,
      builder: (BuildContext context, ConferenceRegistrationState state) {
        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Thanh toán',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                      height: 1.57
                    )
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.clear),
                  color: Colors.white,
                  onPressed: () => Navigator.pop(context)
                )
              ],
            ),
            automaticallyImplyLeading: false
          ),
          body: LoadingIndicator()
        );
      }
    );
  }
}
