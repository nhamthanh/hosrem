import 'package:easy_localization/easy_localization.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosrem_app/app/app_routes.dart';
import 'package:hosrem_app/app/bloc/app_bloc.dart';
import 'package:hosrem_app/common/app_colors.dart';
import 'package:hosrem_app/login/bloc/login_bloc.dart';
import 'package:hosrem_app/login/bloc/login_event.dart';
import 'package:hosrem_app/login/bloc/login_state.dart';
import 'package:hosrem_app/register/registration.dart';
import 'package:hosrem_app/widget/button/default_button.dart';
import 'package:hosrem_app/widget/button/facebook_button.dart';
import 'package:hosrem_app/widget/button/primary_button.dart';
import 'package:hosrem_app/widget/text/edit_text_field.dart';

/// Login form.
@immutable
class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginBloc _loginBloc;
  Router _router;

  @override
  void initState() {
    super.initState();

    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _router = BlocProvider.of<AppBloc>(context).appContext.router;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      builder: (BuildContext context) => _loginBloc,
      child: BlocListener<LoginBloc, LoginState>(
        listener: (BuildContext context, LoginState state) {
          if (state is LoginFailure) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.error}'),
                backgroundColor: Colors.red,
              ),
            );
          }
          if (state is LoginSuccess) {
            _router.navigateTo(context, AppRoutes.homeRoute, clearStack:true, transition: TransitionType.fadeIn);
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(
          bloc: _loginBloc,
          builder: (BuildContext context, LoginState state) {
            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(left: 21.0, right: 21.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    const SizedBox(height: 70.0),
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                      child: Image.asset('assets/images/logo.png'),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: EditTextField(
                            hasLabel: false,
                            title: AppLocalizations.of(context).tr('login.email'),
                            hint: AppLocalizations.of(context).tr('login.email_hint'),
                            onTextChanged: (String value) => print(value),
                            controller: _emailController,
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
                            title: AppLocalizations.of(context).tr('login.password'),
                            hint: AppLocalizations.of(context).tr('login.password_hint'),
                            obscureText: true,
                            onTextChanged: (String value) => print(value),
                            controller: _passwordController,
                          )
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: PrimaryButton(
                            text: AppLocalizations.of(context).tr('login.login'),
                            onPressed: _onLoginButtonPressed,
                          )
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: FacebookButton(
                            text: AppLocalizations.of(context).tr('login.login_with_facebook'),
                            onPressed: _onLoginFacebookButtonPressed,
                          )
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      children: <Widget>[
                        const SizedBox(width: 40.0),
                        const Expanded(
                          child: Divider()
                        ),
                        const SizedBox(width: 5.0),
                        Text(AppLocalizations.of(context).tr('login.or')),
                        const SizedBox(width: 5.0),
                        const Expanded(
                          child: Divider()
                        ),
                        const SizedBox(width: 40.0),
                      ]
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: DefaultButton(
                            backgroundColor: AppColors.lightPrimaryColor,
                            text: AppLocalizations.of(context).tr('login.register'),
                            onPressed: _onRegisterButtonPressed,
                          )
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0)
                  ],
                ),
              )
            );
          },
        )
      )
    );
  }

  bool _validateLoginForm() {
    if (_emailController.text.isEmpty) {
      _showErrorMessage(AppLocalizations.of(context).tr('login.email_is_required'));
      return false;
    }

    if (_passwordController.text.isEmpty) {
      _showErrorMessage(AppLocalizations.of(context).tr('login.password_is_required'));
      return false;
    }

    return true;
  }

  void _showErrorMessage(String message) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _onLoginButtonPressed() {
    if (_validateLoginForm()) {
      _loginBloc.dispatch(LoginButtonPressed(
        email: _emailController.text,
        password: _passwordController.text,
      ));
    }
  }

  void _onRegisterButtonPressed() {
    Navigator.push(
      context,
      MaterialPageRoute<bool>(builder:
        (BuildContext context) => Registration(authService: _loginBloc.authService)
      ),
    );
  }

  void _onLoginFacebookButtonPressed() {
    _loginBloc.dispatch(LoginFacebookButtonPressed());
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
