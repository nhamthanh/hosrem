import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hosrem_app/api/auth/user.dart';
import 'package:hosrem_app/api/survey/question.dart';
import 'package:hosrem_app/api/survey/question_result.dart';
import 'package:hosrem_app/api/survey/section.dart';
import 'package:hosrem_app/api/survey/survey.dart';
import 'package:hosrem_app/auth/auth_service.dart';
import 'package:hosrem_app/common/error_handler.dart';

import '../survey_service.dart';
import 'survey_event.dart';
import 'survey_state.dart';

/// Survey bloc to load surveys.
class SurveyBloc extends Bloc<SurveyEvent, SurveyState> {
  SurveyBloc({ @required this.surveyService, @required this.authService }) :
      assert(surveyService != null), assert(authService != null);

  static const int DEFAULT_PAGE = 0;
  static const int DEFAULT_PAGE_SIZE = 10;

  final SurveyService surveyService;
  final AuthService authService;

  Map<Question, String> _values;
  Survey _survey;
  int _selectedSectionIndex = 0;
  List<QuestionResult> _results;
  @override
  SurveyState get initialState => SurveyLoading();

  @override
  Stream<SurveyState> mapEventToState(SurveyEvent event) async* {
    if (event is LoadSurveyEvent) {
      yield SurveyLoading();

      try {
        _values = <Question, String>{};
        _survey = event.survey;
        if (event.surveyResultId.isNotEmpty) {
          _results = await surveyService.getSurveyResult(event.surveyResultId);
        }

        for (Section section in _survey.sections) {
          section.questions.sort((Question q1, Question q2) => q1.ordinalNumber.compareTo(q2.ordinalNumber));
          if (event.surveyResultId.isNotEmpty) {
            for (int i = 0; i < section.questions.length; i++) {
              final QuestionResult questionResult = _results.singleWhere((QuestionResult result) => result.question.id == section.questions[i].id , orElse: () => null);
              if (questionResult != null && questionResult is QuestionResult) {
                _values[section.questions[i]] =  questionResult.answer;
              }
            }
          }
        }
        yield LoadedSurvey(_survey, values: _values, selectedSectionIndex: _selectedSectionIndex);
      } catch (error) {
        yield SurveyFailure(error: ErrorHandler.extractErrorMessage(error));
      }
    }

    if (event is RatingEvent) {
      try {
        _values[event.question] = event.value;
        if (event.question.answerType == 'Rating') {
          yield LoadedSurvey(_survey, values: _values, selectedSectionIndex: _selectedSectionIndex);
        }
      } catch (error) {
        yield SurveyFailure(error: ErrorHandler.extractErrorMessage(error));
      }
    }

    if (event is ChangeSectionEvent) {
      try {
        _selectedSectionIndex = event.sectionIndex;
        yield LoadedSurvey(_survey, values: _values, selectedSectionIndex: _selectedSectionIndex);
      } catch (error) {
        yield SurveyFailure(error: ErrorHandler.extractErrorMessage(error));
      }
    }

    if (event is SubmitRatingEvent) {
      yield SurveyLoading();

      try {
        final User user = await authService.currentUser();
        await surveyService.submitSurveyResult(event.conferenceId, user.id, event.values);
        yield SubmitSurveySuccess();
      } catch (error) {
        print(error.toString());
        yield SurveyFailure(error: ErrorHandler.extractErrorMessage(error));
      }
    }
  }
}
