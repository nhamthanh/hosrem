import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosrem_app/api/conference/conference.dart';
import 'package:hosrem_app/api/conference/conference_fee.dart';
import 'package:hosrem_app/auth/auth_service.dart';
import 'package:hosrem_app/auth/login_registration.dart';
import 'package:hosrem_app/common/app_assets.dart';
import 'package:hosrem_app/common/app_colors.dart';
import 'package:hosrem_app/common/base_state.dart';
import 'package:hosrem_app/common/date_time_utils.dart';
import 'package:hosrem_app/common/text_styles.dart';
import 'package:hosrem_app/conference/conference_info.dart';
import 'package:hosrem_app/conference/registration/conference_registration.dart';
import 'package:hosrem_app/loading/loading_indicator.dart';
import 'package:hosrem_app/profile/user_service.dart';
import 'package:hosrem_app/survey/survey_introduction.dart';
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

  AuthService authService;

  @override
  void initState() {
    super.initState();
    authService = AuthService(apiProvider);
    _conferenceFeesBloc = ConferenceFeesBloc(
      conferenceService: ConferenceService(apiProvider),
      authService: AuthService(apiProvider),
      userService: UserService(apiProvider, authService),
    );
    _conferenceFeesBloc.dispatch(LoadConferenceFeesByConferenceIdEvent(conferenceId: widget.conference.id, conferenceStatus: widget.conference.status));
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
                          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                                          maxLines: 5,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyles.textStyle18PrimaryBlack
                                        ),
                                        const SizedBox(height: 8.0),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              padding: const EdgeInsets.only(top: 7.0),
                                              child: SvgIcon(AppAssets.locationIcon, size: 16.0, color: AppColors.secondaryGreyColor)
                                            ),
                                            const SizedBox(width: 5.0),
                                            Expanded(
                                              child: Text(
                                                conference.location,
                                                maxLines: 3,
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
                                            child: SvgIcon(AppAssets.calendarIcon, size: 16.0, color: AppColors.secondaryGreyColor)
                                          ),
                                          const SizedBox(width: 5.0),
                                          Text(
                                            conference.startTime == null ? '' : DateTimeUtils.format(conference.startTime.toLocal()),
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
                            const SizedBox(height: 20.0),
                            // Info, address and time of conference
                            ConferenceInfo(conference),
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

            return LoadingIndicator();
          }
        )
      )
    );
  }

  Widget _buildButtonRegistrationWidget(LoadedConferenceFees state) {
    if (state.registeredConference) {
      return Container(
        padding: const EdgeInsets.only(left: 25.0, top: 21.5, bottom: 28.5, right: 25.0),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            PrimaryButton(
              text: AppLocalizations.of(context).tr('conferences.join_code'),
              onPressed: () => _navigateToViewQrCode(state.registrationCode),
            ),
            state.hasToken ? InkWell(
              child: Container(
                padding: const EdgeInsets.only(top: 8.0, left: 15.0, right: 15.0),
                child: Text(
                  'Đánh giá',
                  textAlign: TextAlign.center,
                  style: TextStyles.textStyle11SecondaryGrey
                )
              ),
              onTap: () => _navigateToSurvey(widget.conference.id)
            ) : Container()
          ],
        )
      );
    }

    if (state.allowRegistration) {
      return Container(
        padding: const EdgeInsets.only(left: 25.0, top: 21.5, bottom: 28.5, right: 25.0),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            PrimaryButton(
              text: AppLocalizations.of(context).tr('conferences.register_for_event'),
              onPressed: () => _navigateToRegistration(state.selectedConferenceFee, state.hasToken),
            )
          ],
        )
      );
    }

    return Container();
  }

  Future<void> _navigateToSurvey(String conferenceId) async {
    await pushWidgetWithTransition(
      SurveyIntroduction(conferenceId),
      PageTransitionType.downToUp
    );
  }

  Future<void> _navigateToViewQrCode(String qrCode) async {
    await pushWidget(ConferenceQrCode(qrCode: qrCode));
  }

  Future<void> _navigateToRegistration(List<ConferenceFee> selectedConferenceFees, bool hasToken) async {
    if (!hasToken) {
      await pushWidgetWithTransition(LoginRegistration(), PageTransitionType.downToUp);
      _conferenceFeesBloc.dispatch(LoadConferenceFeesByConferenceIdEvent(conferenceId: widget.conference.id));
      return;
    }

    await pushWidgetWithTransition(
      ConferenceRegistration(conference: widget.conference, conferenceFees: selectedConferenceFees),
      PageTransitionType.downToUp
    );
    _conferenceFeesBloc.dispatch(LoadConferenceFeesByConferenceIdEvent(conferenceId: widget.conference.id));
  }
}
