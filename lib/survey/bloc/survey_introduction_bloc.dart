import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:hosrem_app/api/conference/user_conference.dart';
import 'package:hosrem_app/api/survey/survey.dart';
import 'package:hosrem_app/auth/auth_service.dart';
import 'package:hosrem_app/common/error_handler.dart';
import 'package:hosrem_app/profile/user_service.dart';
import 'package:hosrem_app/survey/bloc/survey_introduction_event.dart';
import 'package:hosrem_app/survey/bloc/survey_introduction_state.dart';
import 'package:hosrem_app/survey/survey_service.dart';

/// Survey Introduction bloc.
class SurveyIntroductionBloc extends Bloc<SurveyIntroductionEvent, SurveyIntroductionState> {
  SurveyIntroductionBloc({@required this.authService, @required this.userService, @required this.surveyService}) :
      assert(userService != null), assert(surveyService != null), assert(authService != null);

  static const int DEFAULT_PAGE = 0;
  static const int DEFAULT_PAGE_SIZE = 1000;
  final UserService userService;
  final AuthService authService;
  final SurveyService surveyService;
  Survey _survey;

  @override
  SurveyIntroductionState get initialState => SurveyIntroductionLoading();

  @override
  Stream<SurveyIntroductionState> mapEventToState(SurveyIntroductionEvent event) async* {
    if (event is LoadSurveyIntroduction) {
      String surveyResultId = '';
      try {
        _survey = await surveyService.getSurveyById(event.conferenceId);
        if (authService.currentUser() != null) {
          final UserConference userConference = await userService.getSpecificRegisteredConference(event.conferenceId);
          if (userConference != null && userConference.surveyResultId != null && userConference.surveyResultId.isNotEmpty) {
            surveyResultId = userConference.surveyResultId;
          }
        } else {
          yield UnauthorizeSurveyIntroduction();
          return;
        }
        yield LoadedSurveyIntroduction(_survey, surveyResultId: surveyResultId);
      } catch (error) {
        yield SurveyIntroductionFailure(error: ErrorHandler.extractErrorMessage(error));
      }
    }
  }

}
