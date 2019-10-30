import 'package:easy_localization/easy_localization.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosrem_app/app/app_routes.dart';
import 'package:hosrem_app/app/bloc/app_bloc.dart';
import 'package:hosrem_app/login/bloc/login_bloc.dart';
import 'package:hosrem_app/login/bloc/login_event.dart';
import 'package:hosrem_app/login/bloc/login_state.dart';
import 'package:hosrem_app/widget/button/primary_button.dart';
import 'package:hosrem_app/widget/text/edit_text_field.dart';

/// Login form.
@immutable
class LoginForm extends StatefulWidget{
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailPhoneController = TextEditingController();
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
    final double height = MediaQuery.of(context).size.height;
    final double spacerHeight = height > 580 ? height - 580 : 0;
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
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.only(left: 28.0, right: 27.0),
                            child: Column(
                              children: <Widget>[
                                const SizedBox(height: 25),
                                Row(
                                  children: <Widget>[
                                    const SizedBox(height: 20),
                                    Expanded(
                                      child: EditTextField(
                                        hasLabel: false,
                                        title: AppLocalizations.of(context).tr('login.email_phone'),
                                        hint: AppLocalizations.of(context).tr('login.email_phone_hint'),
                                        onTextChanged: (String value) => print(value),
                                        controller: _emailPhoneController,
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
                              ]
                            )
                          ),
                          SizedBox(height: spacerHeight),
                          const Divider(),
                          const SizedBox(height: 20.0),
                          Container(
                            padding: const EdgeInsets.only(left: 28.0, right: 27.0),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: PrimaryButton(
                                        text: AppLocalizations.of(context).tr('login.login'),
                                        onPressed: _onLoginButtonPressed,
                                      )
                                    )
                                  ]
                                ),
                                const SizedBox(height: 34.0),
                              ]
                            )
                          ),                   
                        ],
                      ),
                    )
                  ),
                ),
              ]
            );
          },
        )
      )
    );
  }

  bool _validateLoginForm() {
    if (_emailPhoneController.text.isEmpty) {
      _showErrorMessage(AppLocalizations.of(context).tr('login.email_phone_is_required'));
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
        email: _emailPhoneController.text,
        password: _passwordController.text,
      ));
    }
  }

  @override
  void dispose() {
    _emailPhoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
