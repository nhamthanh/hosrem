import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hosrem_app/api/survey/question.dart';
import 'package:hosrem_app/api/survey/question_pagination.dart';
import 'package:hosrem_app/api/survey/section.dart';
import 'package:hosrem_app/api/survey/survey.dart';
import 'package:hosrem_app/common/error_handler.dart';

import '../survey_service.dart';
import 'survey_event.dart';
import 'survey_state.dart';

/// Survey bloc to load surveys.
class SurveyBloc extends Bloc<SurveyEvent, SurveyState> {
  SurveyBloc({@required this.surveyService}) : assert(surveyService != null);

  static const int DEFAULT_PAGE = 0;
  static const int DEFAULT_PAGE_SIZE = 10;

  final SurveyService surveyService;

  Map<Question, String> _values;
  Survey _survey;
  List<Section> _sections;
  int _selectedSectionIndex = 0;

  @override
  SurveyState get initialState => SurveyLoading();

  @override
  Stream<SurveyState> mapEventToState(SurveyEvent event) async* {
    if (event is LoadSurveyEvent) {
      yield SurveyLoading();

      try {
        _values = <Question, String>{};
        _survey = await surveyService.getSurveyById(event.id);
        final QuestionPagination questions = await surveyService.apiProvider.surveyApi.getAllQuestions(<String, int>{
          'page': 0,
          'size': 5,
        });
        _sections = _survey.sections.map((Section section) => section.copyWith(questions: questions.items)).toList();
        yield LoadedSurvey(_survey, _sections, values: _values, selectedSectionIndex: _selectedSectionIndex);
      } catch (error) {
        yield SurveyFailure(error: ErrorHandler.extractErrorMessage(error));
      }
    }

    if (event is RatingEvent) {
      try {
        _values[event.question] = event.value;
        if (event.question.type != 'text') {
          yield LoadedSurvey(_survey, _sections, values: _values, selectedSectionIndex: _selectedSectionIndex);
        }
      } catch (error) {
        yield SurveyFailure(error: ErrorHandler.extractErrorMessage(error));
      }
    }

    if (event is ChangeSectionEvent) {
      try {
        _selectedSectionIndex = event.sectionIndex;
        yield LoadedSurvey(_survey, _sections, values: _values, selectedSectionIndex: _selectedSectionIndex);
      } catch (error) {
        yield SurveyFailure(error: ErrorHandler.extractErrorMessage(error));
      }
    }
  }
}
