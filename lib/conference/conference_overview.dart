import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosrem_app/api/conference/conference.dart';
import 'package:hosrem_app/api/conference/conference_fee.dart';
import 'package:hosrem_app/auth/auth_service.dart';
import 'package:hosrem_app/common/app_assets.dart';
import 'package:hosrem_app/common/app_colors.dart';
import 'package:hosrem_app/common/base_state.dart';
import 'package:hosrem_app/common/date_time_utils.dart';
import 'package:hosrem_app/common/text_styles.dart';
import 'package:hosrem_app/conference/registration/conference_registration.dart';
import 'package:hosrem_app/login/login.dart';
import 'package:hosrem_app/widget/button/primary_button.dart';
import 'package:hosrem_app/widget/svg/svg_icon.dart';
import 'package:page_transition/page_transition.dart';

import 'bloc/conference_fees_bloc.dart';
import 'bloc/conference_fees_event.dart';
import 'bloc/conference_fees_state.dart';
import 'conference_service.dart';
import 'registration/conference_qr_code.dart';
import 'registration/conference_registration_fees.dart';

/// Conference detail page.
class ConferenceOverview extends StatefulWidget {
  const ConferenceOverview({Key key, this.conference}) : super(key: key);

  final Conference conference;

  @override
  State<ConferenceOverview> createState() => _ConferenceOverviewState();
}

class _ConferenceOverviewState extends BaseState<ConferenceOverview> {

  ConferenceFeesBloc _conferenceFeesBloc;

  @override
  void initState() {
    super.initState();

    _conferenceFeesBloc = ConferenceFeesBloc(
      conferenceService: ConferenceService(apiProvider),
      authService: AuthService(apiProvider)
    );
    _conferenceFeesBloc.dispatch(LoadConferenceFeesByConferenceIdEvent(conferenceId: widget.conference.id));
  }

  @override
  Widget build(BuildContext context) {
    final Conference conference = widget.conference;
    return BlocProvider<ConferenceFeesBloc>(
      builder: (BuildContext context) => _conferenceFeesBloc,
      child: BlocListener<ConferenceFeesBloc, ConferenceFeesState>(
        listener: (BuildContext context, ConferenceFeesState state) {
          if (state is ConferenceFeesFailure) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.error}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<ConferenceFeesBloc, ConferenceFeesState>(
          bloc: _conferenceFeesBloc,
          builder: (BuildContext context, ConferenceFeesState state) {
            if (state is LoadedConferenceFees) {
              return Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.all(28.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          conference.title ?? '',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyles.textStyle18PrimaryBlack
                                        ),
                                        const SizedBox(height: 8.0),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              padding: const EdgeInsets.only(top: 4.0),
                                              child: SvgIcon(AppAssets.locationIcon, size: 16.0, color: AppColors.secondaryGreyColor)
                                            ),
                                            const SizedBox(width: 5.0),
                                            Expanded(
                                              child: Text(
                                                conference.location,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyles.textStyle14SecondaryGrey
                                              )
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      const SizedBox(height: 7.0),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            padding: const EdgeInsets.only(top: 4.0),
                                            child: SvgIcon(AppAssets.calendarIcon, size: 16.0, color: AppColors.secondaryGreyColor)
                                          ),
                                          const SizedBox(width: 5.0),
                                          Text(
                                            conference.startTime == null ? '' : DateTimeUtils.format(conference.startTime),
                                            style: TextStyles.textStyle10PrimaryRed
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              )
                            ),
                            Container(
                              padding: const EdgeInsets.all(28.0),
                              child: CachedNetworkImage(
                                imageUrl: conference.banner != null ? '${apiConfig.apiBaseUrl}conferences/${conference.id}/banner?fileName=${conference.banner}' : 'https://',
                                placeholder: (BuildContext context, String url) => Center(child: const CircularProgressIndicator()),
                                errorWidget: (BuildContext context, String url, Object error) =>
                                  Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
                                    Container(
                                      height: 168.0,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                        color: const Color.fromRGBO(52, 169, 255, 0.1)
                                      ),
                                      child: Image.asset(AppAssets.conferencePlaceholder))
                                  ])),
                            ),
                            Container(
                              height: 20.0,
                              color: const Color(0xFFF5F8FA),
                            ),
                            const SizedBox(height: 9.0),
                            Container(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Text(
                                    AppLocalizations.of(context).tr('conferences.about_event'),
                                    style: TextStyles.textStyle16PrimaryBlackBold
                                  ),
                                  const SizedBox(height: 10.0),
                                  Text(
                                    conference.description ?? '',
                                    style: TextStyles.textStyle16PrimaryBlack
                                  )
                                ],
                              )
                            ),
                            Container(
                              height: 20.0,
                              color: const Color(0xFFF5F8FA),
                            ),
                            const SizedBox(height: 17.0),
                            Container(
                              padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 0.0, top: 0.0),
                              child: ConferenceRegistrationFees(state.conferenceFees)
                            ),
                            const SizedBox(height: 20.0),
                          ],
                        )
                      )
                    ),
                    const Divider(),
                    _buildButtonRegistrationWidget(state)
                  ],
                )
              );
            }

            return Container();
          }
        )
      )
    );
  }

  Widget _buildButtonRegistrationWidget(LoadedConferenceFees state) {
    if (state.registeredConference) {
      return Container(
        padding: const EdgeInsets.only(left: 25.0, top: 28.5, bottom: 28.5, right: 25.0),
        color: Colors.white,
        child: PrimaryButton(
          text: 'Quét Mã Tham Dự Hội Nghị',
          onPressed: _navigateToViewQrCode,
        )
      );
    }

    if (state.allowRegistration) {
      return Container(
        padding: const EdgeInsets.only(left: 25.0, top: 28.5, bottom: 28.5, right: 25.0),
        color: Colors.white,
        child: PrimaryButton(
          text: AppLocalizations.of(context).tr('conferences.register_for_event'),
          onPressed: () => _navigateToRegistration(state.selectedConferenceFee, state.hasToken),
        )
      );
    }

    return Container();
  }

  void _navigateToViewQrCode() {
    Navigator.push(
      context,
      MaterialPageRoute<bool>(builder:
        (BuildContext context) => const ConferenceQrCode(qrCode: 'ZM1230291232132321320')
      ),
    );
  }

  Future<void> _navigateToRegistration(List<ConferenceFee> selectedConferenceFees, bool hasToken) async {
    if (!hasToken) {
      await Navigator.push<dynamic>(context, PageTransition<dynamic>(
        type: PageTransitionType.downToUp,
        child: Login()
      ));

      return;
    }

    await Navigator.push<dynamic>(context, PageTransition<dynamic>(
      type: PageTransitionType.downToUp,
      child: ConferenceRegistration(conference: widget.conference, conferenceFees: selectedConferenceFees)
    ));

    _conferenceFeesBloc.dispatch(LoadConferenceFeesByConferenceIdEvent(conferenceId: widget.conference.id));
  }
}
