import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hosrem_app/auth/forgot_password/forgot_password.dart';
import 'package:hosrem_app/common/base_state.dart';
import 'package:hosrem_app/common/text_styles.dart';
import 'package:hosrem_app/widget/text/edit_text_field.dart';

/// Login form.
@immutable
class LoginForm extends StatefulWidget {
  const LoginForm(this.emailPhoneController, this.passwordController, { this.validEmail = true, this.validPassword = true });

  final TextEditingController emailPhoneController;
  final TextEditingController passwordController;
  final bool validEmail;
  final bool validPassword;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends BaseState<LoginForm> {

  bool _validEmail;
  bool _validPassword;

  @override
  void didUpdateWidget(LoginForm oldWidget) {
    super.didUpdateWidget(oldWidget);

    _validEmail = widget.validEmail;
    _validPassword = widget.validPassword;
  }

  @override
  void initState() {
    super.initState();

    _validEmail = widget.validEmail;
    _validPassword = widget.validPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
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
                              error: _validEmail ? null : AppLocalizations.of(context).tr('login.email_phone_is_required'),
                              onTextChanged: (String value) => setState(() => _validEmail = value.isNotEmpty),
                              controller: widget.emailPhoneController,
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
                              error: _validPassword ? null : AppLocalizations.of(context).tr('login.password_is_required'),
                              obscureText: true,
                              onTextChanged: (String value) => setState(() => _validPassword = value.isNotEmpty),
                              controller: widget.passwordController,
                            )
                          ),
                        ],
                      ),
                      const SizedBox(height: 15.0),
                      Material(
                        color: Colors.white,
                        child: InkWell(
                          highlightColor: Colors.white,
                          focusColor: Colors.white,
                          onTap: () {
                            _onForgetPasswordPress();
                          },
                          child: Text(
                            AppLocalizations.of(context).tr('login.forgot_password'),
                            style: TextStyles.textStyle11PrimaryBlueBold,
                          ),
                        ),
                      ),
                    ]
                  )
                ),
              ],
            ),
          )
        ),
      ]
    );
  }

  Future<void> _onForgetPasswordPress() async {
    await pushWidget(const ForgotPassword());
  }
}
