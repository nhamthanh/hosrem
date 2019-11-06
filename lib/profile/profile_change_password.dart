import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosrem_app/api/auth/user.dart';
import 'package:hosrem_app/api/auth/user_password.dart';
import 'package:hosrem_app/auth/auth_service.dart';
import 'package:hosrem_app/common/app_colors.dart';
import 'package:hosrem_app/common/base_state.dart';
import 'package:hosrem_app/profile/bloc/profile_passowrd_bloc.dart';
import 'package:hosrem_app/profile/bloc/profile_password_event.dart';
import 'package:hosrem_app/profile/bloc/profile_password_state.dart';
import 'package:hosrem_app/widget/button/primary_button.dart';
import 'package:hosrem_app/widget/text/edit_text_field.dart';
import 'package:loading_overlay/loading_overlay.dart';

/// Change password form.
@immutable
class ChangePasswordForm extends StatefulWidget {
  const ChangePasswordForm(this.user);

  final User user;

  @override
  State<ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends BaseState<ChangePasswordForm> {

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  bool _validPassword;
  bool _validNewPassword;
  bool _validConfirmPassword;
  bool _checked = false;
  User _user;
  String passwordConfirmError;
  ProfilePasswordBloc _profilePasswordBloc;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    
  @override
  void didUpdateWidget(ChangePasswordForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    _checked = passwordController.text.isNotEmpty & newPasswordController.text.isNotEmpty
      & confirmPasswordController.text.isNotEmpty & (newPasswordController.text
      == confirmPasswordController.text);
  }

  @override
  void initState() {
    super.initState();
    _initStates();
    _profilePasswordBloc = ProfilePasswordBloc(authService: AuthService(apiProvider));
  }

  void _initStates() {
    _user = widget.user;
    _validPassword = true;
    _validNewPassword = true;
    _validConfirmPassword = true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfilePasswordBloc>(
      builder: (BuildContext context) => _profilePasswordBloc,
      child: BlocListener<ProfilePasswordBloc, ProfilePasswordState>(
        listener: (BuildContext context, ProfilePasswordState state) async {
          if (state is ProfilePasswordSuccess) {
            apiProvider.cacheManager.emptyCache();
            _showUpdateSuccessDialog();
          }

          if (state is ProfilePasswordFailure) {
            _scaffoldKey.currentState.showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.red,
              ),
            );
          }

          if (state is ProfilePasswordValidationState) {
            if (!state.checked) {
              _scaffoldKey.currentState.showSnackBar(
                SnackBar(
                  content: Text(AppLocalizations.of(context).tr('profile.password_is_wrong')),
                  backgroundColor: Colors.red,
                ),
              );
            }
          }
        },
        child: BlocBuilder<ProfilePasswordBloc, ProfilePasswordState>(
          bloc: _profilePasswordBloc,
          builder: (BuildContext context, ProfilePasswordState state) {
            return LoadingOverlay(
              isLoading: state is ProfilePasswordLoading,
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
        title: Text(AppLocalizations.of(context).tr('profile.change_your_password')),
        centerTitle: true
      ),
      body: Center ( 
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.only(left: 27.0, right: 28.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              EditTextField(
                hasLabel: true,
                title: AppLocalizations.of(context).tr('profile.password'),
                hint: AppLocalizations.of(context).tr('profile.password_hint'),
                error: _validPassword ? null : AppLocalizations.of(context).tr('profile.password_is_required'),
                onTextChanged: (String value) => setState(() => _validPassword = value.isNotEmpty),
                obscureText: true,
                controller: passwordController,
              ),
              const SizedBox(height: 20.0),
              EditTextField(
                hasLabel: true,
                title: AppLocalizations.of(context).tr('profile.new_password'),
                hint: AppLocalizations.of(context).tr('profile.new_password_hint'),
                error: _validNewPassword ? null : AppLocalizations.of(context).tr('profile.new_password_is_required'),
                onTextChanged: (String value) => setState(() => _validNewPassword = value.isNotEmpty),
                obscureText: true,
                controller: newPasswordController,
              ),
              const SizedBox(height: 20.0),
              EditTextField(
                hasLabel: true,
                title: AppLocalizations.of(context).tr('profile.confirm_password'),
                hint: AppLocalizations.of(context).tr('profile.confirm_password_hint'),
                error: _validConfirmPassword ? null : passwordConfirmError,
                onTextChanged: (String value) => setState(() {
                  if (value.isEmpty) {
                    _validConfirmPassword = false;
                    passwordConfirmError = AppLocalizations.of(context).tr('profile.confirm_password_is_required');
                  } else if (value != newPasswordController.text) {
                    _validConfirmPassword = false;
                    passwordConfirmError = AppLocalizations.of(context).tr('profile.password_not_match');
                  } else {
                     _validConfirmPassword = true;
                  }
                }),
                obscureText: true,
                controller: confirmPasswordController,
              ),
              const SizedBox(height: 22.0),
            ],
          )
        )
      ),
      bottomNavigationBar: BottomAppBar (
        child: Column( 
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
          Container(
            height: 10.0,
            color: AppColors.backgroundConferenceColor,
          ),
          Row( children: <Widget>[
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 25.0, top: 27.0, bottom: 28.5, right: 25.0),
                child: PrimaryButton(
                text: AppLocalizations.of(context).tr('my_profile.save'),
                onPressed: _checked ? () => _changePasswordClick(_user) : null,
                )
              ),
            )
          ],)
        ],) 
      ),
    );
  }

  void _changePasswordClick(User user) {
    if(isValidate(user)) {
      final String oldPassword = passwordController.text;
      final String newPassword = newPasswordController.text;
      _profilePasswordBloc.dispatch(ChangePasswordButtonPressed(user.id, UserPassword(null, newPassword, oldPassword)));
    }
  }

  bool isValidate(User user) {
    if (_validPassword & _validNewPassword & _validConfirmPassword & (newPasswordController.text
      == confirmPasswordController.text)) {
      return true;
    } else {
      return false;
    }
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
