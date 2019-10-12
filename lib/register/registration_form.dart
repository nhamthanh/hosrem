import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosrem_app/common/base_state.dart';
import 'package:hosrem_app/register/bloc/registration_bloc.dart';
import 'package:hosrem_app/register/bloc/registration_event.dart';
import 'package:hosrem_app/register/bloc/registration_state.dart';
import 'package:hosrem_app/widget/button/primary_button.dart';
import 'package:hosrem_app/widget/text/edit_text_field.dart';

/// Registration form.
@immutable
class RegistrationForm extends StatefulWidget {
  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends BaseState<RegistrationForm> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _workingPlaceController = TextEditingController();

  RegistrationBloc _registrationBloc;

  @override
  void initState() {
    super.initState();

    _registrationBloc = BlocProvider.of<RegistrationBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegistrationBloc>(
      builder: (BuildContext context) => _registrationBloc,
      child:BlocListener<RegistrationBloc, RegistrationState>(
        listener: (BuildContext context, RegistrationState state) {
          if (state is RegistrationSuccess) {
            _showSuccessDialog();
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
                    const SizedBox(height: 20.0),
                    EditTextField(
                      title: AppLocalizations.of(context).tr('registration.first_name'),
                      hint: AppLocalizations.of(context).tr('registration.first_name_hint'),
                      onTextChanged: (String value) => print(value),
                      controller: _firstNameController,
                    ),
                    const SizedBox(height: 20.0),
                    EditTextField(
                      title: AppLocalizations.of(context).tr('registration.last_name'),
                      hint: AppLocalizations.of(context).tr('registration.last_name_hint'),
                      onTextChanged: (String value) => print(value),
                      controller: _lastNameController,
                    ),
                    const SizedBox(height: 20.0),
                    EditTextField(
                      title: AppLocalizations.of(context).tr('registration.email'),
                      hint: AppLocalizations.of(context).tr('registration.email_hint'),
                      onTextChanged: (String value) => print(value),
                      controller: _emailController,
                    ),
                    const SizedBox(height: 20.0),
                    EditTextField(
                      title: AppLocalizations.of(context).tr('registration.password'),
                      hint: AppLocalizations.of(context).tr('registration.password_hint'),
                      obscureText: true,
                      onTextChanged: (String value) => print(value),
                      controller: _passwordController,
                    ),
                    const SizedBox(height: 20.0),
                    EditTextField(
                      title: AppLocalizations.of(context).tr('registration.confirm_password'),
                      hint: AppLocalizations.of(context).tr('registration.confirm_password_hint'),
                      obscureText: true,
                      onTextChanged: (String value) => print(value),
                      controller: _confirmPasswordController,
                    ),
                    const SizedBox(height: 20.0),
                    EditTextField(
                      title: AppLocalizations.of(context).tr('registration.job_title'),
                      hint: AppLocalizations.of(context).tr('registration.job_title_hint'),
                      onTextChanged: (String value) => print(value),
                      controller: _jobTitleController,
                    ),
                    const SizedBox(height: 20.0),
                    EditTextField(
                      title: AppLocalizations.of(context).tr('registration.working_place'),
                      hint: AppLocalizations.of(context).tr('registration.working_place_hint'),
                      onTextChanged: (String value) => print(value),
                      controller: _workingPlaceController,
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: PrimaryButton(
                            text: AppLocalizations.of(context).tr('registration.sign_up'),
                            onPressed: _onSignupButtonPressed,
                          )
                        ),
                      ],
                    ),
                    const SizedBox(height: 25.0)
                  ],
                ),
              )
            );
          },
        )
      )
    );
  }

  bool _validateRegisterForm() {
    if (_firstNameController.text.isEmpty) {
      _showErrorMessage(AppLocalizations.of(context).tr('registration.first_name_is_required'));
      return false;
    }

    if (_lastNameController.text.isEmpty) {
      _showErrorMessage(AppLocalizations.of(context).tr('registration.last_name_is_required'));
      return false;
    }

    if (_emailController.text.isEmpty) {
      _showErrorMessage(AppLocalizations.of(context).tr('registration.email_is_required'));
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

    if (_jobTitleController.text.isEmpty) {
      _showErrorMessage(AppLocalizations.of(context).tr('registration.job_title_is_required'));
      return false;
    }

    if (_workingPlaceController.text.isEmpty) {
      _showErrorMessage(AppLocalizations.of(context).tr('registration.working_place_is_required'));
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
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        jobTitle: _jobTitleController.text,
        workingPlace: _workingPlaceController.text,
      ));
    }
  }

  void _showSuccessDialog() {
    showAlert(
      context: context,
      body: AppLocalizations.of(context).tr('registration.registration_success'),
      actions: <AlertAction>[
        AlertAction(text: 'OK', onPressed: () => Navigator.pop(context))
      ]
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _jobTitleController.dispose();
    _workingPlaceController.dispose();

    _registrationBloc.dispose();
    super.dispose();
  }
}
