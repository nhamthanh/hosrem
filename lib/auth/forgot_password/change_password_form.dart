import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hosrem_app/common/app_colors.dart';
import 'package:hosrem_app/common/text_styles.dart';
import 'package:hosrem_app/widget/button/primary_button.dart';
import 'package:hosrem_app/widget/text/edit_text_field.dart';

// Change Password Form class
class ChangePasswordForm extends StatefulWidget {
  const ChangePasswordForm(this.passwordController, this.confirmPasswordController, this._validPassword, this._validConfirmPassword, this.changePassword);

  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final bool _validPassword;
  final bool _validConfirmPassword;
  final VoidCallback changePassword;

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePasswordForm> {

  bool _validPassword;

  bool _validConfirmPassword;

  @override
  void didUpdateWidget(ChangePasswordForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    _validPassword = widget._validPassword;
    _validConfirmPassword = widget._validPassword;
  }

  @override
  void initState() {
    super.initState();
    _validPassword = widget._validPassword;
    _validConfirmPassword = widget._validPassword;
  }

  @override
  Widget build(BuildContext context) {

    return Column (    
      children: <Widget>[
        Expanded (
          child: Container (
            color: Colors.white,
            padding: const EdgeInsets.only(left: 28.0, right: 27.0),
            child: ListView(
              children: <Widget>[
                const SizedBox(height: 24.0),
                Row(
                  children: <Widget> [
                    Expanded(child : Container(
                      padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                      child : Text(
                        AppLocalizations.of(context).tr('login.change_your_password'),
                        textAlign: TextAlign.center,
                        style: TextStyles.textStyle22PrimaryBlackBold
                      )
                    )),
                  ]
                ),
                const SizedBox(height: 12.0),
                Row(
                  children: <Widget> [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                        child : Text(
                          AppLocalizations.of(context).tr('login.enter_new_pass'),
                          textAlign: TextAlign.center,
                          style: TextStyles.textStyle18PrimaryBlack,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2
                        ),
                      )
                    ),
                  ]
                ),
                const SizedBox(height: 48.0),
                EditTextField(
                  hasLabel: false,
                  title: AppLocalizations.of(context).tr('profile.new_password'),
                  hint: AppLocalizations.of(context).tr('profile.password_hint'),
                  error: _validPassword ? null : AppLocalizations.of(context).tr('registration.password_is_required'),
                  onTextChanged: (String value) => setState(() => _validPassword = value.isNotEmpty),
                  obscureText: true,
                  controller: widget.passwordController,
                ),
                const SizedBox(height: 20.0),
                EditTextField(
                  hasLabel: false,
                  title: AppLocalizations.of(context).tr('profile.confirm_password'),
                  hint: AppLocalizations.of(context).tr('profile.confirm_password_hint'),
                  error: _validConfirmPassword ? null : AppLocalizations.of(context).tr('registration.password_not_match'),
                  onTextChanged: (String value) => setState(() => _validConfirmPassword = value == widget.passwordController.text),
                  obscureText: true,
                  controller: widget.confirmPasswordController,
                ),
              ],
            ),
          )
        ),
        Container(
          color: Colors.white,
          padding: const EdgeInsets.only(left: 25.0, top: 27.0, bottom: 28.5, right: 25.0),
          child: Row(children: <Widget>[
            Expanded(
              child: PrimaryButton(
                backgroundColor: AppColors.lightPrimaryColor,
                text: AppLocalizations.of(context).tr('my_profile.save'),
                onPressed: widget.passwordController.text.isNotEmpty
                  && widget.passwordController.text == widget.confirmPasswordController.text 
                  ? () => widget.changePassword() : null,
              )
            )
          ],)
        )
      ],
    );
  }
}