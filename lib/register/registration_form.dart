import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hosrem_app/common/text_styles.dart';
import 'package:hosrem_app/widget/button/primary_button.dart';
import 'package:hosrem_app/widget/text/edit_text_field.dart';

/// Registration form.
@immutable
class RegistrationForm extends StatefulWidget {
  const RegistrationForm(this.fullNameController, this.emailController, this.phoneController, this.passwordController,
    this.handleRegisterClick, this.onChecked, {
      this.validEmail = true,
      this.validFullName = true,
      this.validPhone = true,
      this.validPassword = true,
      this.checked = false
    }
  );

  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final VoidCallback handleRegisterClick;
  final Function(bool) onChecked;

  final bool validFullName;
  final bool validPhone;
  final bool validEmail;
  final bool validPassword;
  final bool checked;

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {

  bool _validFullName;
  bool _validPhone;
  bool _validEmail;
  bool _validPassword;
  bool _checked;

  @override
  void didUpdateWidget(RegistrationForm oldWidget) {
    super.didUpdateWidget(oldWidget);

    _initStates();
  }

  @override
  void initState() {
    super.initState();

    _initStates();
  }

  void _initStates() {
    _validFullName = widget.validFullName;
    _validPhone = widget.validPhone;
    _validEmail = widget.validEmail;
    _validPassword = widget.validPassword;
    _checked = widget.checked;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 28.0, right: 27.0),
      child: Column(
        children: <Widget>[
          const SizedBox(height: 25),
          EditTextField(
            hasLabel: false,
            title: AppLocalizations.of(context).tr('registration.full_name'),
            hint: AppLocalizations.of(context).tr('registration.full_name_hint'),
            error: _validFullName ? null : AppLocalizations.of(context).tr('registration.full_name_is_required'),
            onTextChanged: (String value) => setState(() => _validFullName = value.isNotEmpty),
            controller: widget.fullNameController,
          ),
          const SizedBox(height: 20.0),
          EditTextField(
            hasLabel: false,
            title: AppLocalizations.of(context).tr('registration.email'),
            hint: AppLocalizations.of(context).tr('registration.email_hint'),
            error: _validEmail ? null : AppLocalizations.of(context).tr('registration.email_is_required'),
            onTextChanged: (String value) => setState(() => _validEmail = value.isNotEmpty),
            controller: widget.emailController,
          ),
          const SizedBox(height: 20.0),
          EditTextField(
            hasLabel: false,
            title: AppLocalizations.of(context).tr('registration.phone'),
            hint: AppLocalizations.of(context).tr('registration.phone_hint'),
            error: _validPhone ? null : AppLocalizations.of(context).tr('registration.phone_is_required'),
            onTextChanged: (String value) => setState(() => _validPhone = value.isNotEmpty),
            controller: widget.phoneController,
          ),
          const SizedBox(height: 20.0),
          EditTextField(
            hasLabel: false,
            title: AppLocalizations.of(context).tr('registration.password'),
            hint: AppLocalizations.of(context).tr('registration.password_hint'),
            error: _validPassword ? null : AppLocalizations.of(context).tr('registration.password_is_required'),
            onTextChanged: (String value) => setState(() => _validPassword = value.isNotEmpty),
            obscureText: true,
            controller: widget.passwordController,
          ),
          const SizedBox(height: 22.0),
          Container(
            transform: Matrix4.translationValues(-12.0, 0.0, 0.0),
            child: Row(
              children: <Widget>[
                Checkbox(
                  value: _checked,
                  onChanged: (bool checked) {
                    setState(() => _checked = checked);
                    widget.onChecked(_checked);
                  }
                ),
                Expanded(
                  child: InkWell(
                    child: Text(
                      AppLocalizations.of(context).tr('registration.confirm'),
                      style: TextStyles.textStyle14PrimaryBlack
                    ),
                    onTap: () {
                      setState(() => _checked = !_checked);
                      widget.onChecked(_checked);
                    }
                  )
                ),
              ],
            )
          ),
          const SizedBox(height: 28.5),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: PrimaryButton(
                    text: AppLocalizations.of(context).tr('registration.register'),
                    onPressed: widget.handleRegisterClick,
                  )
                ),
              )
            ]
          ),
        ],
      )
    );
  }
}
