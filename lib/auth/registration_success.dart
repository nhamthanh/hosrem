import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hosrem_app/common/app_assets.dart';
import 'package:hosrem_app/common/text_styles.dart';
import 'package:hosrem_app/widget/button/primary_button.dart';

/// Register success page.
class RegistrationSuccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(AppAssets.confirmIcon),
            const SizedBox(height: 40.0),
            Row(
              children: <Widget> [
                Expanded(child : Container(
                  padding: const EdgeInsets.only(left: 46.0, right: 45.0),
                  child : Text(
                    AppLocalizations.of(context).tr('registration.registration_success'),
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
                      AppLocalizations.of(context).tr('registration.verification_send_to_email'),
                      textAlign: TextAlign.center,
                      style: TextStyles.textStyle18PrimaryBlack,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2
                    ),
                  )
                ),
              ]
            ),
          ]
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: const EdgeInsets.only(left: 27.0, right: 28.0, bottom: 34.0),
          child : PrimaryButton(
            text: AppLocalizations.of(context).tr('login.back_login'),
            onPressed: () {
              Navigator.pop(context, true);
            }
          )
        )
      )
    );
  }
}
