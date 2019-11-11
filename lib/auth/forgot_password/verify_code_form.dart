
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hosrem_app/common/app_colors.dart';
import 'package:hosrem_app/common/text_styles.dart';
import 'package:hosrem_app/widget/button/primary_button.dart';
import 'package:hosrem_app/widget/text/edit_text_field.dart';

// Verify Code class
class VerifyCodeForm extends StatefulWidget {
  const VerifyCodeForm(this.codeController, this._validCode, this.verifyCode);
  
  final TextEditingController codeController;
  final bool _validCode;
  final VoidCallback verifyCode;

  @override
  _VerifyCodeState createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCodeForm> {

  bool _validCode;
  String errorMessage;

  @override
  void didUpdateWidget(VerifyCodeForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    _validCode = widget._validCode;
    errorMessage = widget._validCode ? null : AppLocalizations.of(context).tr('login.code_is_wrong');
  }

  @override
  void initState() {
    super.initState();
    _validCode = widget._validCode;
    errorMessage = widget._validCode ? null : AppLocalizations.of(context).tr('login.code_is_wrong');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Expanded (
            child: ListView(
              children: <Widget>[
                const SizedBox(height: 50.0),
                Row(
                  children: <Widget> [
                    Expanded(child : Container(
                      padding: const EdgeInsets.only(left: 46.0, right: 45.0),
                      child : Text(
                        AppLocalizations.of(context).tr('login.verify_code_hint'),
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
                          AppLocalizations.of(context).tr('login.verify_code_title'),
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
                Row(
                  children: <Widget> [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 28.0, right: 27.0),
                        child : EditTextField (
                          hint: AppLocalizations.of(context).tr('login.verify_code_hint'),
                          hasLabel: false,
                          title: AppLocalizations.of(context).tr('login.verify_code'),
                          controller: widget.codeController,
                          error: _validCode ? null : errorMessage,
                          onTextChanged: (String value) => setState(() {
                            errorMessage = AppLocalizations.of(context).tr('login.code_is_required');
                            _validCode = value.isNotEmpty;
                          }),
                        ),
                      )
                    ),
                  ]
                ),
              ]
            ),
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.only(left: 25.0, top: 27.0, bottom: 28.5, right: 25.0),
            child: Row(children: <Widget>[
              Expanded(
                child: PrimaryButton(
                  backgroundColor: AppColors.lightPrimaryColor,
                  text: AppLocalizations.of(context).tr('profile.next'),
                  onPressed: widget.codeController.text.isNotEmpty ? () => widget.verifyCode() : null,
                )
              )
            ],)
          ),
        ]
      ),
    );
  }
}