
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hosrem_app/common/app_assets.dart';
import 'package:hosrem_app/common/app_colors.dart';
import 'package:hosrem_app/common/text_styles.dart';
import 'package:hosrem_app/widget/button/primary_button.dart';

// Email Inform class
class EmailInform extends StatelessWidget {

  const EmailInform(this.emailInform);

  final VoidCallback emailInform;

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
                        AppLocalizations.of(context).tr('login.reset_email_sent'),
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
                          AppLocalizations.of(context).tr('login.check_email_inform'),
                          textAlign: TextAlign.center,
                          style: TextStyles.textStyle18PrimaryBlack,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2
                        ),
                      )
                    ),
                  ]
                ),
                const SizedBox(height: 5.0),
                Image.asset(AppAssets.passwordImage),
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
                  onPressed: () => emailInform(),
                )
              )
            ],)
          ),
        ]
      ),
    );
  }
}