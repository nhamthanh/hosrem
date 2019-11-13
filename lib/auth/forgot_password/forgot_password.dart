import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosrem_app/auth/auth_service.dart';
import 'package:hosrem_app/auth/forgot_password/bloc/forgot_passowrd_bloc.dart';
import 'package:hosrem_app/auth/forgot_password/bloc/forgot_password_event.dart';
import 'package:hosrem_app/auth/forgot_password/bloc/forgot_password_state.dart';
import 'package:hosrem_app/auth/forgot_password/change_password_form.dart';
import 'package:hosrem_app/auth/forgot_password/email_inform.dart';
import 'package:hosrem_app/auth/forgot_password/reset_password_success.dart';
import 'package:hosrem_app/auth/forgot_password/verify_code_form.dart';
import 'package:hosrem_app/auth/forgot_password/verify_email_form.dart';

import 'package:hosrem_app/common/app_colors.dart';
import 'package:hosrem_app/common/base_state.dart';
import 'package:loading_overlay/loading_overlay.dart';

/// Forgot password class.
@immutable
class ForgotPassword extends StatefulWidget {
  const ForgotPassword();

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends BaseState<ForgotPassword> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController = TextEditingController();
  bool _validEmail;
  bool _validCode;
  bool _validPassword;
  bool _validConfirmPassword;
  String errorMessage;
  ForgotPasswordBloc _forgotPasswordBloc;
  PageController _pageController;
  
  int _page = 0;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    
  @override
  void didUpdateWidget(ForgotPassword oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _initStates();
    _forgotPasswordBloc = ForgotPasswordBloc(authService: AuthService(apiProvider));
  }

  void _initStates() {
    _validEmail = true;
    _validCode = true;
    _validPassword = true;
    _validConfirmPassword = true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ForgotPasswordBloc>(
      builder: (BuildContext context) => _forgotPasswordBloc,
      child: BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
        listener: (BuildContext context, ForgotPasswordState state) async {
          if (state is VerifyEmailResultState) {
            if (state.result) {
               FocusScope.of(context).requestFocus(FocusNode());
              _page += 1;
              _pageController.jumpToPage( _page);
            } else {
              errorMessage = state.message;
            }
            _validEmail = state.result;
          }

          if (state is VerifyCodeResultState) {
            if (state.result) {
              _page += 1;
              _pageController.jumpToPage( _page);
            }
            _validCode = state.result;
          }

          if (state is ForgotPasswordSuccess) {
            _pageController.jumpToPage(++_page);
          }

          if (state is ForgetPasswordFailure) {
            _scaffoldKey.currentState.showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
          bloc: _forgotPasswordBloc,
          builder: (BuildContext context, ForgotPasswordState state) {
            return LoadingOverlay(
              isLoading: state is ForgetPasswordLoading,
              child: buildContent(),
            );
          }
        )
      )
    );
  }

  Widget buildContent() {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          _page != 4 ? IconButton(
            icon: Icon(Icons.clear),
            color: AppColors.primaryGreyColor,
            onPressed: () => Navigator.pop(context)
          ) : Container()
        ],
        centerTitle: true
      ),
      body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: <Widget>[
            VerifyEmailForm(emailController, _validEmail, _verifyEmailClick, errorMessage),
            EmailInform(_emailInformClick),
            VerifyCodeForm(codeController, _validCode, _verifyCodeClick),
            ChangePasswordForm(passwordController, passwordConfirmController, _validPassword, _validConfirmPassword, _changePasswordClick),
            ResetPasswordSuccess()
          ]
      ),
    );
  }

  void _verifyEmailClick() {
    _forgotPasswordBloc.dispatch(VerifyEmailEvent(emailController.text));
  }

  void _emailInformClick() {
    _page += 1;
    _pageController.jumpToPage( _page);
  }

  void _verifyCodeClick() {
    _forgotPasswordBloc.dispatch(VerifyCodeEvent(codeController.text));
  }

  void _changePasswordClick() {
    _forgotPasswordBloc.dispatch(ChangePasswordEvent(codeController.text, passwordController.text));
  }

  void _showUpdateSuccessDialog() {
    showAlert(
      context: context,
      body: AppLocalizations.of(context).tr('my_profile.your_password_updated'),
      actions: <AlertAction>[
        AlertAction(text: 'OK', onPressed: () => Navigator.pop(context))
      ]
    );
  }
}
