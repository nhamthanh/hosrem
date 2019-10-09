import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosrem_app/api/auth/user.dart';
import 'package:hosrem_app/auth/auth_service.dart';
import 'package:hosrem_app/common/base_state.dart';
import 'package:hosrem_app/widget/button/primary_button.dart';
import 'package:hosrem_app/widget/text/edit_text_field.dart';
import 'package:loading_overlay/loading_overlay.dart';

import 'bloc/profile_bloc.dart';
import 'bloc/profile_event.dart';
import 'bloc/profile_state.dart';

/// Update profile page.
@immutable
class UpdateProfile extends StatefulWidget {
  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends BaseState<UpdateProfile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _workingPlaceController = TextEditingController();

  ProfileBloc _profileBloc;
  User _user;

  @override
  void initState() {
    super.initState();

    _profileBloc = ProfileBloc(authService: AuthService(apiProvider));
    _profileBloc.dispatch(LoadProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileBloc>(
      builder: (BuildContext context) => _profileBloc,
      child: BlocListener<ProfileBloc, ProfileState>(
        listener: (BuildContext context, ProfileState state) {
          if (state is ProfileFailure) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.error}'),
                backgroundColor: Colors.red,
              ),
            );
          }

          if (state is UpdateProfileSuccess) {
            _showUpdateSuccessDialog();
          }
        },
        child: BlocBuilder<ProfileBloc, ProfileState>(
          bloc: _profileBloc,
          builder: (BuildContext context, ProfileState state) {
            if (state is ProfileSuccess) {
              _user = state.user;
              _emailController.text = state.user.email;
              _firstNameController.text = state.user.firstName;
              _lastNameController.text = state.user.lastName;
              _jobTitleController.text = state.user.jobTitle;
              _workingPlaceController.text = state.user.workingPlace;
            }

            return Scaffold(
              key: _scaffoldKey,
              appBar: AppBar(
                title: const Text('My Profile'),
                centerTitle: true
              ),
              body: LoadingOverlay(
                isLoading: state is ProfileLoading,
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(21.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: EditTextField(
                                title: 'First Name',
                                hint: 'Your first name',
                                controller: _firstNameController,
                              )
                            ),
                          ],
                        ),
                        const SizedBox(height: 20.0),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: EditTextField(
                                title: 'Last Name',
                                hint: 'Your last name',
                                controller: _lastNameController,
                              )
                            ),
                          ],
                        ),
                        const SizedBox(height: 20.0),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: EditTextField(
                                title: 'Email',
                                hint: 'Your email',
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
                                title: 'Job Title',
                                hint: 'Your job title',
                                onTextChanged: (String value) => print(value),
                                controller: _jobTitleController,
                              )
                            ),
                          ],
                        ),
                        const SizedBox(height: 20.0),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: EditTextField(
                                title: 'Working Place',
                                hint: 'Your working place',
                                onTextChanged: (String value) => print(value),
                                controller: _workingPlaceController,
                              )
                            ),
                          ],
                        ),
                        const SizedBox(height: 40.0),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: PrimaryButton(
                                text: 'SAVE',
                                onPressed: _onSaveButtonPressed,
                              )
                            ),
                          ],
                        )
                      ]
                    )
                  )
                )
              )
            );
          }
        )
      )
    );
  }

  void _showUpdateSuccessDialog() {
    showAlert(
      context: context,
      title: 'Update Profile',
      body: 'Your profile has been updated successfully.',
      actions: <AlertAction>[
        AlertAction(text: 'OK', onPressed: () => Navigator.pop(context))
      ]
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

  void _onSaveButtonPressed() {
    if (_validateRegisterForm()) {
      final String email = _emailController.text;
      final String firstName = _firstNameController.text;
      final String lastName = _lastNameController.text;
      final String jobTitle = _jobTitleController.text;
      final String workingPlace = _workingPlaceController.text;

      final User user = _user.copyWith(
        email: email,
        firstName: firstName,
        lastName: lastName,
        jobTitle: jobTitle,
        workingPlace: workingPlace
      );

      _profileBloc.dispatch(SaveProfileEvent(user));
    }
  }

  void _showErrorMessage(String message) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  void dispose() {
    _profileBloc.dispose();
    super.dispose();
  }
}
