import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:hosrem_app/api/conference/conference_fee.dart';
import 'package:hosrem_app/api/conference/conference_fees.dart';
import 'package:hosrem_app/api/conference/user_conference.dart';
import 'package:hosrem_app/auth/auth_service.dart';
import 'package:hosrem_app/common/error_handler.dart';
import 'package:hosrem_app/profile/user_service.dart';
import 'package:hosrem_app/survey/bloc/survey_introduction_event.dart';
import 'package:hosrem_app/survey/bloc/survey_introduction_state.dart';

/// Survey Introduction bloc.
class SurveyIntroductionBloc extends Bloc<SurveyIntroductionEvent, SurveyIntroductionState> {
  SurveyIntroductionBloc({@required this.authService, @required this.userService}) :
    assert(authService != null);

  static const int DEFAULT_PAGE = 0;
  static const int DEFAULT_PAGE_SIZE = 1000;
  final UserService userService;
  final AuthService authService;

  @override
  SurveyIntroductionState get initialState => SurveyIntroductionLoading();

  @override
  Stream<SurveyIntroductionState> mapEventToState(SurveyIntroductionEvent event) async* {
    if (event is LoadSurveyIntroduction) {
      bool surveyResult = false;
      try {
        if (authService.currentUser() != null) {
          final UserConference userConference = await userService.getSpecificRegisteredConference(event.id);
          if (userConference != null && userConference.surveyResultId != null && userConference.surveyResultId.isNotEmpty) {
            surveyResult = true;
          }
        } else {
          yield UnauthorizeSurveyIntroduction();
          return;
        }
        yield LoadedSurveyIntroduction(surveyResult: surveyResult);
      } catch (error) {
        yield SurveyIntroductionFailure(error: ErrorHandler.extractErrorMessage(error));
      }
    }
  }

}
