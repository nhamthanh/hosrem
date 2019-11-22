import 'package:easy_localization/easy_localization.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosrem_app/app/app_routes.dart';
import 'package:hosrem_app/auth/auth_service.dart';
import 'package:hosrem_app/common/app_assets.dart';
import 'package:hosrem_app/common/app_colors.dart';
import 'package:hosrem_app/common/base_state.dart';
import 'package:hosrem_app/common/text_styles.dart';
import 'package:hosrem_app/profile/user_service.dart';
import 'package:hosrem_app/survey/bloc/survey_introduction_bloc.dart';
import 'package:hosrem_app/survey/bloc/survey_introduction_event.dart';
import 'package:hosrem_app/survey/bloc/survey_introduction_state.dart';
import 'package:hosrem_app/survey/survey_service.dart';
import 'package:hosrem_app/widget/button/primary_button.dart';
import 'package:loading_overlay/loading_overlay.dart';

import 'survey.dart';

/// Survey introduction page.
class SurveyIntroduction extends StatefulWidget {
  const SurveyIntroduction(this.id, { Key key }) : super(key: key);

  final String id;

  @override
  _SurveyIntroductionState createState() => _SurveyIntroductionState();
}

class _SurveyIntroductionState extends BaseState<SurveyIntroduction> {

  SurveyIntroductionBloc _surveyIntroductionBloc;
  AuthService _authService;
  String errorMessage = '';
  @override
  void initState() {
    super.initState();
    _authService = AuthService(apiProvider);
    _surveyIntroductionBloc = SurveyIntroductionBloc(surveyService: SurveyService(apiProvider), authService: _authService, userService: UserService(apiProvider, _authService));
    _surveyIntroductionBloc.dispatch(LoadSurveyIntroduction(widget.id));
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider<SurveyIntroductionBloc>(
      builder: (BuildContext context) => _surveyIntroductionBloc,
      child: BlocListener<SurveyIntroductionBloc, SurveyIntroductionState>(
        listener: (BuildContext context, SurveyIntroductionState state) async {
          if (state is UnauthorizeSurveyIntroduction) {
            await router.navigateTo(context, AppRoutes.homeRoute, clearStack: true, transition: TransitionType.fadeIn);
          }
          if (state is LoadedSurveyIntroduction) {
            if (state.surveyResultId.isNotEmpty) {
              await Navigator.pushReplacement(context, MaterialPageRoute<bool>(builder: (BuildContext context) => Survey(state.survey, surveyResultId: state.surveyResultId, key: const Key('survey'))));
            } else if (state.survey == null) {
              errorMessage = AppLocalizations.of(context).tr('survey.no_info_survey');
            }
          }
        },
        child: BlocBuilder<SurveyIntroductionBloc, SurveyIntroductionState>(
          bloc: _surveyIntroductionBloc,
          builder: (BuildContext context, SurveyIntroductionState state) {
            return LoadingOverlay(
              isLoading: state is SurveyIntroductionLoading,
              child: buildContent(context, state),
            );
          }
        )
      )
    );
  }

  Scaffold buildContent(BuildContext context, SurveyIntroductionState state) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).tr('survey.survey')),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.clear),
            color: Colors.white,
            onPressed: () => Navigator.pop(context)
          )
        ]
      ),
      body: state is LoadedSurveyIntroduction ? Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 28.0),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 100.0),
                      Image.asset(AppAssets.surveyImage),
                      const SizedBox(height: 52.0),
                      Text(
                        errorMessage.isEmpty ? 'Rất mong bạn có thể dành ít phút để nhận xét về hội nghị :)' : errorMessage,
                        textAlign: TextAlign.center,
                        style: TextStyles.textStyle20PrimaryBlack
                      )
                    ],
                  )
                )
              )
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
              child: PrimaryButton(
                text: errorMessage.isEmpty ? 'Bắt Đầu' : AppLocalizations.of(context).tr('button.back'),
                onPressed: () => _navigateToSurveyOrBack(context, state),
              )
            )
          ],
        )
      ) : Container(color: Colors.white,)
    );
  }

  Future<void> _navigateToSurveyOrBack(BuildContext context, LoadedSurveyIntroduction state) async {
    if (errorMessage.isEmpty) {
      await Navigator.pushReplacement(context, MaterialPageRoute<bool>(builder: (BuildContext context) => Survey(state.survey, surveyResultId: state.surveyResultId, key: const Key('survey'))));
    } else {
      Navigator.pop(context);
    }
  }
}
