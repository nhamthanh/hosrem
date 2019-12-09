import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosrem_app/api/survey/question.dart';
import 'package:hosrem_app/api/survey/section.dart';
import 'package:hosrem_app/api/survey/survey.dart' as api_model;
import 'package:hosrem_app/auth/auth_service.dart';
import 'package:hosrem_app/common/app_colors.dart';
import 'package:hosrem_app/common/base_state.dart';
import 'package:hosrem_app/common/text_styles.dart';
import 'package:hosrem_app/connection/connection_provider.dart';
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
  const Survey(this.conferenceId, { this.surveyResultId = '', Key key }) : super(key: key);

  final String conferenceId;

  final String surveyResultId;

  @override
  State<Survey> createState() => _SurveyState();
}

class _SurveyState extends BaseState<Survey> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final PageController _pageController = PageController();
  SurveyBloc _surveyBloc;
  String errorMessage = '';
  String closeOrSubmit = '';

  @override
  void initState() {
    super.initState();
    final AuthService authService = AuthService(apiProvider);
    _surveyBloc = SurveyBloc(surveyService: SurveyService(apiProvider, authService), authService: authService);
    _surveyBloc.dispatch(LoadSurveyEvent(widget.conferenceId, surveyResultId: widget.surveyResultId));
  }

  @override
  Widget build(BuildContext context) {
    closeOrSubmit = widget.surveyResultId.isEmpty ? 'Gởi Đi': AppLocalizations.of(context).tr('button.edit');
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).tr('survey.survey')),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.clear),
            color: Colors.white,
            onPressed: () => Navigator.pop(context, false)
          )
        ]
      ),
      body: ConnectionProvider(
        child: BlocProvider<SurveyBloc>(
          builder: (BuildContext context) => _surveyBloc,
          child: BlocListener<SurveyBloc, SurveyState>(
            listener: (BuildContext context, SurveyState state) {
              if (state is SurveyFailure) {
                errorMessage = state.error;
              }

              if (state is SubmitSurveySuccess) {
                _showResultDialog();
              }
            },
            child: BlocBuilder<SurveyBloc, SurveyState>(
              bloc: _surveyBloc,
              builder: (BuildContext context, SurveyState state) {
                final api_model.Survey survey = state is LoadedSurvey ? state.survey : null;
                final List<Section> sections = survey != null ? survey.sections : <Section>[];
                final Map<Question, String> values = state is LoadedSurvey ? state.values : <Question, String>{};
                final int selectedSectionIndex = state is LoadedSurvey ? state.selectedSectionIndex : 0;
                return LoadingOverlay(
                  isLoading: state is SurveyLoading,
                  child: state is SurveyLoading ? Container() : Column(
                    children: <Widget>[
                      Expanded(
                        child: _buildPageView(survey, sections, values),
                      ),
                      Container(
                        height: 10.0,
                        color: AppColors.backgroundConferenceColor,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border(top: const BorderSide(width: 1.0, color: AppColors.editTextFieldBorderColor)),
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.only(left: 25.0, top: 28.5, bottom: 28.5, right: 25.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Expanded(
                              child: DefaultButton(
                                text: AppLocalizations.of(context).tr('button.back'),
                                onPressed: selectedSectionIndex == 0 ? null : () => _goBack(selectedSectionIndex)
                              )
                            ),
                            const SizedBox(width: 17.0),
                            Expanded(
                              child: PrimaryButton(
                                text: selectedSectionIndex >= sections.length - 1 ?  closeOrSubmit : AppLocalizations.of(context).tr('button.next'),
                                onPressed: _buildNextOnPressed(survey, selectedSectionIndex, sections, values)
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
      )
    );
  }

  Function _buildNextOnPressed(api_model.Survey survey, int selectedSectionIndex, List<Section> sections,
    Map<Question, String> values) {
    if (survey == null) {
      return null;
    }

    return selectedSectionIndex >= sections.length - 1
      ? () => _submitRating(values)
      : () => _goForward(sections, selectedSectionIndex);
  }

  Widget _buildPageView(api_model.Survey survey, List<Section> sections, Map<Question, String> values) {
    if (survey == null) {
      return Center(
        child: Container (
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Text(
            errorMessage.isEmpty ? AppLocalizations.of(context).tr('survey.no_info_survey'): errorMessage,
            style: TextStyles.textStyle16PrimaryBlack,
            textAlign: TextAlign.center,
            maxLines: 2,
          ) ,
        )
      );
    }

    return PageView(
      controller: _pageController,
      onPageChanged: _pageChanged,
      physics: const NeverScrollableScrollPhysics(),
      children: sections.map((Section section) => SingleChildScrollView(
        child: SurveySection(
          section,
          values: values,
          rateChanged: _handleRateChanged,
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

  void _submitRating(Map<Question, String> values) {
    _surveyBloc.dispatch(SubmitRatingEvent(values, widget.conferenceId, surveyResultId: widget.surveyResultId));
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

  void _showResultDialog() {
    showAlert(
      context: context,
      body: widget.surveyResultId.isEmpty ? 'Cảm ơn bạn đã tham gia khảo sát' : 'Cảm ơn bạn đã cập nhật khảo sát',
      actions: <AlertAction>[
        AlertAction(text: 'OK', onPressed: () {
          Navigator.pop(context, true);
        })
      ]
    );
  }
}
