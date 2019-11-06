import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosrem_app/api/survey/question.dart';
import 'package:hosrem_app/api/survey/section.dart';
import 'package:hosrem_app/common/app_colors.dart';
import 'package:hosrem_app/common/base_state.dart';
import 'package:hosrem_app/widget/button/default_button.dart';
import 'package:hosrem_app/widget/button/primary_button.dart';
import 'package:loading_overlay/loading_overlay.dart';

import 'bloc/survey_bloc.dart';
import 'bloc/survey_event.dart';
import 'bloc/survey_state.dart';
import 'survey_section.dart';
import 'survey_service.dart';

/// Survey page.
@immutable
class Survey extends StatefulWidget {
  const Survey(this.id, { Key key }) : super(key: key);

  final String id;

  @override
  State<Survey> createState() => _SurveyState();
}

class _SurveyState extends BaseState<Survey> {

  SurveyBloc _surveyBloc;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();

    _surveyBloc = SurveyBloc(surveyService: SurveyService(apiProvider));
    _surveyBloc.dispatch(LoadSurveyEvent(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Khảo sát'),
        centerTitle: true,
        automaticallyImplyLeading: false
      ),
      body: BlocProvider<SurveyBloc>(
        builder: (BuildContext context) => _surveyBloc,
        child: BlocListener<SurveyBloc, SurveyState>(
          listener: (BuildContext context, SurveyState state) {
          },
          child: BlocBuilder<SurveyBloc, SurveyState>(
            bloc: _surveyBloc,
            builder: (BuildContext context, SurveyState state) {
              final List<Section> sections = state is LoadedSurvey ? state.sections : <Section>[];
              final Map<Question, String> values = state is LoadedSurvey ? state.values : <Question, String>{};
              final int selectedSectionIndex = state is LoadedSurvey ? state.selectedSectionIndex : 0;
              return LoadingOverlay(
                isLoading: state is SurveyLoading,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: _buildPageView(sections, values),
                    ),
                    Container(
                      height: 10.0,
                      color: AppColors.backgroundConferenceColor,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(top: BorderSide(width: 1.0, color: AppColors.editTextFieldBorderColor)),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.only(left: 25.0, top: 28.5, bottom: 28.5, right: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Expanded(
                            child: DefaultButton(
                              text: 'Quay Lại',
                              onPressed: selectedSectionIndex == 0 ? null : () => _goBack(selectedSectionIndex)
                            )
                          ),
                          const SizedBox(width: 17.0),
                          Expanded(
                            child: PrimaryButton(
                              text: selectedSectionIndex >= sections.length - 1 ? 'Gởi Đi' : 'Tiếp Tục',
                              onPressed: selectedSectionIndex >= sections.length - 1 ? _submitRating : () => _goForward(sections, selectedSectionIndex)
                            )
                          )
                        ],
                      )
                    )
                  ],
                )
              );
            }
          )
        )
      )
    );
  }

  Widget _buildPageView(List<Section> sections, Map<Question, String> values) {
    return PageView(
      controller: _pageController,
      onPageChanged: _pageChanged,
      physics: const NeverScrollableScrollPhysics(),
      children: sections.map((Section section) => SingleChildScrollView(
        child: SurveySection(
          section,
          values: values,
          rateChanged: _handleRateChanged
        )
      )).toList()
    );
  }

  void _pageChanged(int index) {
    _surveyBloc.dispatch(ChangeSectionEvent(index));
  }

  void _goBack(int selectedSectionIndex) {
    if (selectedSectionIndex > 0) {
      _pageController.animateToPage(selectedSectionIndex - 1, duration: Duration(milliseconds: 500), curve: Curves.ease);
    }
  }

  void _submitRating() {

  }

  void _goForward(List<Section> sections, int selectedSectionIndex) {
    if (selectedSectionIndex < sections.length - 1) {
      _pageController.animateToPage(selectedSectionIndex + 1, duration: Duration(milliseconds: 500), curve: Curves.ease);
    }
  }

  void _handleRateChanged(Question question, String value) {
    _surveyBloc.dispatch(RatingEvent(question, value));
  }

  @override
  void dispose() {
    _surveyBloc.dispose();
    super.dispose();
  }
}
