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
  const Survey(this.id, { Key key }) : super(key: key);

  final String id;

  @override
  State<Survey> createState() => _SurveyState();
}

class _SurveyState extends BaseState<Survey> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final PageController _pageController = PageController();
  SurveyBloc _surveyBloc;
  final List<ScrollController> _controllers = <ScrollController>[];
  final Map<int, bool> _pageEnable = <int, bool>{};
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageEnable[currentPage] = false;
    _surveyBloc = SurveyBloc(surveyService: SurveyService(apiProvider), authService: AuthService(apiProvider));
    _surveyBloc.dispatch(LoadSurveyEvent(widget.id));
  }

  @override
  Widget build(BuildContext context) {  
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Khảo sát'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.clear),
            color: Colors.white,
            onPressed: () => Navigator.pop(context)
          )
        ]
      ),
      body: ConnectionProvider(
        child: BlocProvider<SurveyBloc>(
          builder: (BuildContext context) => _surveyBloc,
          child: BlocListener<SurveyBloc, SurveyState>(
            listener: (BuildContext context, SurveyState state) {
              if (state is SurveyFailure) {
                _scaffoldKey.currentState.showSnackBar(
                  SnackBar(
                    content: Text('${state.error}'),
                    backgroundColor: Colors.red,
                  ),
                );
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
                if (_controllers.isEmpty) {
                  for (int i = 0; i < sections.length; i++) {
                    _controllers.add(ScrollController());
                    _controllers[i].addListener(_scrollListener);
                  }
                }
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
                                text: 'Quay Lại',
                                onPressed: selectedSectionIndex == 0 ? null : () => _goBack(selectedSectionIndex)
                              )
                            ),
                            const SizedBox(width: 17.0),
                            Expanded(
                              child: PrimaryButton(
                                text: selectedSectionIndex >= sections.length - 1 ? 'Gởi Đi' : 'Tiếp Tục',
                                onPressed: checkEnable() ? _buildNextOnPressed(survey, selectedSectionIndex, sections, values) : null
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
        child: Text(
          'Chưa có thông tin về khảo sát',
          style: TextStyles.textStyle16PrimaryBlack
        )
      );
    }

    return PageView(
      controller: _pageController,
      onPageChanged: _pageChanged,
      physics: const NeverScrollableScrollPhysics(),
      children: sections.map((Section section) => SingleChildScrollView(
        controller: _controllers[currentPage],
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
      currentPage--;
      _pageController.animateToPage(selectedSectionIndex - 1, duration: Duration(milliseconds: 500), curve: Curves.ease);
    }
  }

  void _submitRating(Map<Question, String> values) {
    _surveyBloc.dispatch(SubmitRatingEvent(values, widget.id));
  }

  bool checkEnable() {
    if (_controllers[currentPage].hasClients) {
      if (_controllers[currentPage].offset == 0.0 && _controllers[currentPage].position.maxScrollExtent == 0.0 && !_controllers[currentPage].position.outOfRange) {
        setState(() {
          _pageEnable[currentPage] = true;
        });
      }
    }
    return _pageEnable[currentPage];
  }

  void _goForward(List<Section> sections, int selectedSectionIndex) {
    if (selectedSectionIndex < sections.length - 1) {
      currentPage++;
      _pageController.animateToPage(selectedSectionIndex + 1, duration: Duration(milliseconds: 500), curve: Curves.ease);
      if (!_pageEnable.containsKey(currentPage)) {
        _pageEnable[currentPage] = false;
      }
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
      body: 'Cảm ơn bạn đã tham gia khảo sát',
      actions: <AlertAction>[
        AlertAction(text: 'OK', onPressed: () {
          Navigator.pop(context);
        })
      ]
    );
  }

  void _scrollListener() {
    if (_controllers[currentPage].offset >= _controllers[currentPage].position.maxScrollExtent &&
        !_controllers[currentPage].position.outOfRange) {
        setState(() {
          _pageEnable[currentPage] = true;
        });
    }
  }
}
