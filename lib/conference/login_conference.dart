import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosrem_app/api/conference/conference.dart';
import 'package:hosrem_app/auth/auth_service.dart';
import 'package:hosrem_app/common/app_colors.dart';
import 'package:hosrem_app/common/base_state.dart';
import 'package:hosrem_app/common/text_styles.dart';
import 'package:hosrem_app/connection/connection_provider.dart';
import 'package:hosrem_app/widget/button/primary_button.dart';
import 'package:hosrem_app/widget/text/edit_text_field.dart';
import 'package:loading_overlay/loading_overlay.dart';

import 'bloc/login_conference_bloc.dart';
import 'bloc/login_conference_event.dart';
import 'bloc/login_conference_state.dart';
import 'conference_service.dart';

/// Login conference page.
class LoginConference extends StatefulWidget {
  const LoginConference(this.conference);

  final Conference conference;

  @override
  State<LoginConference> createState() => _LoginConferenceState();
}

class _LoginConferenceState extends BaseState<LoginConference> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _registrationCodeController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  LoginConferenceBloc _loginConferenceBloc;

  @override
  void initState() {
    super.initState();

    _loginConferenceBloc = LoginConferenceBloc(AuthService(apiProvider), ConferenceService(apiProvider));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginConferenceBloc>(
      builder: (BuildContext context) => _loginConferenceBloc,
      child: BlocListener<LoginConferenceBloc, LoginConferenceState>(
        listener: (BuildContext context, LoginConferenceState state) {
          if (state is LoginConferenceFailure) {
            _scaffoldKey.currentState.showSnackBar(
              SnackBar(
                content: Text('${state.error}'),
                backgroundColor: Colors.red,
              ),
            );
          }

          if (state is LoginConferenceSuccess) {
            Navigator.pop(context, true);
          }
        },
        child: BlocBuilder<LoginConferenceBloc, LoginConferenceState>(
          bloc: _loginConferenceBloc,
          builder: (BuildContext context, LoginConferenceState state) {
            return LoadingOverlay(
              isLoading: state is LoginConferenceLoading,
              child: Scaffold(
                key: _scaffoldKey,
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                  automaticallyImplyLeading: false,
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(Icons.clear),
                      color: AppColors.primaryGreyColor,
                      onPressed: () => Navigator.pop(context)
                    )
                  ],
                  centerTitle: true
                ),
                body: ConnectionProvider(
                  child: _buildPageContent(state)
                )
              )
            );
          }
        )
      )
    );
  }

  Widget _buildPageContent(LoginConferenceState state) {
    Map<String, bool> fields;
    if (state is LoginConferenceValidation) {
      fields = state.fields;
    }
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(left: 28.0, right: 27.0),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 30),
                  const Text(
                    'Vui lòng cung cấp thông tin đăng ký hội nghị của bạn',
                    textAlign: TextAlign.center,
                    style: TextStyles.textStyle20PrimaryBlack
                  ),
                  const SizedBox(height: 25),
                  Row(
                    children: <Widget>[
                      const SizedBox(height: 20),
                      Expanded(
                        child: EditTextField(
                          hasLabel: false,
                          title: '',
                          hint: 'Nhập họ và tên',
                          error: fields != null && !fields['fullName'] ? 'Vui lòng nhập họ và tên' : null,
                          onTextChanged: (String value) => _handleFormTextChanged('fullName', value),
                          controller: _fullNameController,
                        )
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: EditTextField(
                          hasLabel: false,
                          title: '',
                          hint: 'Nhập mã hội nghị',
                          error: fields != null && !fields['registrationCode'] ? 'Vui lòng nhập mã hội nghị' : null,
                          onTextChanged: (String value) => _handleFormTextChanged('registrationCode', value),
                          controller: _registrationCodeController,
                        )
                      ),
                    ],
                  ),
                  const SizedBox(height: 28.5),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: PrimaryButton(
                            text: 'Đăng Nhập',
                            onPressed: _loginAsRegistrationCode,
                          )
                        ),
                      )
                    ],
                  )
                ]
              )
            ),
          ],
        )
      )
    );
  }

  void _handleFormTextChanged(String name, String value) {
    _loginConferenceBloc.dispatch(ValidateFormFieldEvent(name: name, value: value));
  }

  void _loginAsRegistrationCode() {
    _loginConferenceBloc.dispatch(LoginConferencePressedEvent(
      fullName: _fullNameController.text,
      registrationCode: _registrationCodeController.text,
      conference: widget.conference
    ));
  }

  @override
  void dispose() {
    _loginConferenceBloc.dispose();
    super.dispose();
  }
}
