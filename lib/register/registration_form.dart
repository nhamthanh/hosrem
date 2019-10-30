import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosrem_app/common/app_colors.dart';
import 'package:hosrem_app/common/base_state.dart';
import 'package:hosrem_app/register/bloc/registration_bloc.dart';
import 'package:hosrem_app/register/bloc/registration_event.dart';
import 'package:hosrem_app/register/bloc/registration_state.dart';
import 'package:hosrem_app/register/registration_success.dart' as registration_success_page;


import 'package:hosrem_app/widget/button/primary_button.dart';
import 'package:hosrem_app/widget/text/edit_text_field.dart';

/// Registration form.
@immutable
class RegistrationForm extends StatefulWidget {
  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends BaseState<RegistrationForm> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool agree = false;
  RegistrationBloc _registrationBloc;

  @override
  void initState() {
    super.initState();

    _registrationBloc = BlocProvider.of<RegistrationBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double spacerHeight = height > 750 ? height - 750 : 0;
    return BlocProvider<RegistrationBloc>(
      builder: (BuildContext context) => _registrationBloc,
      child:BlocListener<RegistrationBloc, RegistrationState>(
        listener: (BuildContext context, RegistrationState state) async {
          if (state is RegistrationSuccess) {     
            await Navigator.push(context, MaterialPageRoute<bool>(
                builder: (BuildContext context) => registration_success_page.RegistrationSuccess()
              )
            );
          }

          if (state is RegistrationFailure) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.error}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<RegistrationBloc, RegistrationState>(
          bloc: _registrationBloc,
          builder: (BuildContext context, RegistrationState state) {
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
                              EditTextField(
                                hasLabel: false,
                                title: AppLocalizations.of(context).tr('registration.full_name'),
                                hint: AppLocalizations.of(context).tr('registration.full_name_hint'),
                                onTextChanged: (String value) => print(value),
                                controller: _fullNameController,
                              ),
                              const SizedBox(height: 20.0),
                              EditTextField(
                                hasLabel: false,
                                title: AppLocalizations.of(context).tr('registration.email'),
                                hint: AppLocalizations.of(context).tr('registration.email_hint'),
                                onTextChanged: (String value) => print(value),
                                controller: _emailController,
                              ),
                              const SizedBox(height: 20.0),
                              EditTextField(
                                hasLabel: false,
                                title: AppLocalizations.of(context).tr('registration.phone'),
                                hint: AppLocalizations.of(context).tr('registration.phone_hint'),
                                onTextChanged: (String value) => print(value),
                                controller: _phoneController,
                              ),
                              const SizedBox(height: 20.0),
                              EditTextField(
                                hasLabel: false,
                                title: AppLocalizations.of(context).tr('registration.password'),
                                hint: AppLocalizations.of(context).tr('registration.password_hint'),
                                obscureText: true,
                                onTextChanged: (String value) => print(value),
                                controller: _passwordController,
                              ),
                              const SizedBox(height: 20.0),
                              EditTextField(
                                hasLabel: false,
                                title: AppLocalizations.of(context).tr('registration.confirm_password'),
                                hint: AppLocalizations.of(context).tr('registration.confirm_password_hint'),
                                obscureText: true,
                                onTextChanged: (String value) => print(value),
                                controller: _confirmPasswordController,
                              ),
                              const SizedBox(height: 22.0),
                              CheckboxListTile(
                                activeColor: AppColors.lightPrimaryColor,
                                title: Text(AppLocalizations.of(context).tr('registration.confirm')),
                                controlAffinity: ListTileControlAffinity.leading,
                                value: agree,
                                onChanged: (bool value) {
                                    setState(() { agree = value; });
                                },
                              ),
                            ],
                          )
                        ),
                        SizedBox(height: spacerHeight),
                        const Divider(),
                        const SizedBox(height: 15.0),
                        Container(
                          padding: const EdgeInsets.only(left: 21.0, right: 21.0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: PrimaryButton(
                                      text: AppLocalizations.of(context).tr('registration.sign_up'),
                                      onPressed: agree ? _onSignupButtonPressed : null,
                                    )
                                  )
                                ]
                              ),
                              const SizedBox(height: 34.0),
                            ]
                          )
                        ),
                        const SizedBox(height: 15.0),
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

  bool _validateRegisterForm() {
    if (_fullNameController.text.isEmpty) {
      _showErrorMessage(AppLocalizations.of(context).tr('registration.full_name_is_required'));
      return false;
    }

    if (_emailController.text.isEmpty) {
      _showErrorMessage(AppLocalizations.of(context).tr('registration.email_is_required'));
      return false;
    }

    if (_phoneController.text.isEmpty) {
      _showErrorMessage(AppLocalizations.of(context).tr('registration.phone_is_required'));
      return false;
    }

    if (_passwordController.text.isEmpty) {
      _showErrorMessage(AppLocalizations.of(context).tr('registration.password_is_required'));
      return false;
    }

    if (_confirmPasswordController.text.isEmpty) {
      _showErrorMessage(AppLocalizations.of(context).tr('registration.confirm_password_is_required'));
      return false;
    }

    if (_confirmPasswordController.text != _passwordController.text) {
      _showErrorMessage(AppLocalizations.of(context).tr('registration.password_not_match'));
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

  void _onSignupButtonPressed() {
    if (_validateRegisterForm()) {
      _registrationBloc.dispatch(RegisterButtonPressed(
        fullName: _fullNameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        password: _passwordController.text,
      ));
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    _registrationBloc.dispose();
    super.dispose();
  }
}
