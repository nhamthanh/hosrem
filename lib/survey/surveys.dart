import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosrem_app/common/base_state.dart';
import 'package:hosrem_app/loading/loading_indicator.dart';

import 'bloc/surveys_bloc.dart';
import 'bloc/surveys_state.dart';

/// Surveys page.
class Surveys extends StatefulWidget {
  @override
  State<Surveys> createState() => _SurveysState();
}

class _SurveysState extends BaseState<Surveys> {

  SurveysBloc _surveysBloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).tr('notifications.notification')),
        centerTitle: true
      ),
      body: BlocProvider<SurveysBloc>(
        builder: (BuildContext context) => _surveysBloc,
        child: BlocListener<SurveysBloc, SurveysState>(
          listener: (BuildContext context, SurveysState state) {

          },
          child: BlocBuilder<SurveysBloc, SurveysState>(
            bloc: _surveysBloc,
            builder: (BuildContext context, SurveysState state) {
              return LoadingIndicator();
            }
          )
        )
      )
    );
  }

  @override
  void dispose() {
    _surveysBloc.dispose();
    super.dispose();
  }
}
