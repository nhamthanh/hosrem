
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hosrem_app/common/app_colors.dart';
import 'package:hosrem_app/common/text_styles.dart';
import 'package:hosrem_app/widget/button/primary_button.dart';
import 'package:hosrem_app/widget/text/edit_text_field.dart';

// Verify Email class
class VerifyEmailForm extends StatefulWidget {
  const VerifyEmailForm(this.emailController, this.validEmail, this.verifyEmail, this.errorMesage);
  
  final TextEditingController emailController;

  final VoidCallback verifyEmail;

  final String errorMesage;

  final bool validEmail;

  @override
  _VerifyEmailFormState createState() => _VerifyEmailFormState();
}

class _VerifyEmailFormState extends State<VerifyEmailForm> {

  bool _validEmail;

  String errorMessage;

  @override
  void didUpdateWidget(VerifyEmailForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    _validEmail = widget.validEmail;
    errorMessage = widget.validEmail ? null : widget.errorMesage;
  }

  @override
  void initState() {
    super.initState();
    _validEmail = widget.validEmail;
    errorMessage = widget.validEmail ? null : widget.errorMesage;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  const SizedBox(height: 50.0),
                  Row(
                    children: <Widget> [
                      Expanded(child : Container(
                        padding: const EdgeInsets.only(left: 46.0, right: 45.0),
                        child : Text(
                          AppLocalizations.of(context).tr('login.forgot_password'),
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
                          padding: const EdgeInsets.only(left: 46.0, right: 45.0),
                          child : Text(
                            AppLocalizations.of(context).tr('login.verification_email_title'),
                            textAlign: TextAlign.center,
                            style: TextStyles.textStyle18PrimaryBlack,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        )
                      ),
                    ]
                  ),
                  const SizedBox(height: 48.0),
                  Row(
                    children: <Widget> [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(left: 28.0, right: 27.0),
                          child : EditTextField (
                            hint: AppLocalizations.of(context).tr('login.email_hint'),
                            hasLabel: false,
                            title: AppLocalizations.of(context).tr('login.email'),
                            error: _validEmail ? null : errorMessage,
                            controller: widget.emailController,
                            onTextChanged: (String value) => setState(() {
                              errorMessage = AppLocalizations.of(context).tr('login.email_is_required');
                              _validEmail = value.isNotEmpty;
                            }),
                          ),
                        )
                      ),
                    ]
                  ),
                  const SizedBox(height: 20.0),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.only(left: 25.0, top: 27.0, bottom: 28.5, right: 25.0),
              child: Row(children: <Widget>[
                Expanded(
                  child: PrimaryButton(
                    backgroundColor: AppColors.lightPrimaryColor,
                    text: AppLocalizations.of(context).tr('login.reset_password'),
                    onPressed: widget.emailController.text.isNotEmpty ? () => widget.verifyEmail() : null,
                  )
                )
              ],)
            )
          ]
      ),
    );
  }
}