import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosrem_app/api/conference/conference.dart';
import 'package:hosrem_app/api/conference/conference_fee.dart';
import 'package:hosrem_app/auth/auth_service.dart';
import 'package:hosrem_app/common/app_assets.dart';
import 'package:hosrem_app/common/app_colors.dart';
import 'package:hosrem_app/common/base_state.dart';
import 'package:hosrem_app/common/currency_utils.dart';
import 'package:hosrem_app/common/text_styles.dart';
import 'package:hosrem_app/conference/bloc/conference_registration_bloc.dart';
import 'package:hosrem_app/conference/bloc/conference_registration_event.dart';
import 'package:hosrem_app/conference/bloc/conference_registration_state.dart';
import 'package:hosrem_app/membership/promotion.dart';
import 'package:hosrem_app/widget/button/primary_button.dart';
import 'package:hosrem_app/widget/svg/svg_icon.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../conference_service.dart';
import 'conference_payment.dart';

/// Conference registration page.
@immutable
class ConferenceRegistration extends StatefulWidget {
  const ConferenceRegistration({Key key, this.conference, this.conferenceFees}) : super(key: key);

  final Conference conference;
  final List<ConferenceFee> conferenceFees;

  @override
  State<ConferenceRegistration> createState() => _ConferenceRegistrationState();
}

class _ConferenceRegistrationState extends BaseState<ConferenceRegistration> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  ConferenceRegistrationBloc _conferenceRegistrationBloc;

  @override
  void initState() {
    super.initState();

    _conferenceRegistrationBloc = ConferenceRegistrationBloc(
      conferenceService: ConferenceService(apiProvider),
      authService: AuthService(apiProvider)
    );
    _conferenceRegistrationBloc.dispatch(ConferenceRegistrationDataEvent(widget.conference, widget.conferenceFees));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ConferenceRegistrationBloc>(
      builder: (BuildContext context) => _conferenceRegistrationBloc,
      child: BlocListener<ConferenceRegistrationBloc, ConferenceRegistrationState>(
        listener: (BuildContext context, ConferenceRegistrationState state) {
          if (state is ConferenceRegistrationFailure) {
            _scaffoldKey.currentState.showSnackBar(
              SnackBar(
                content: Text('${state.error}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<ConferenceRegistrationBloc, ConferenceRegistrationState>(
          bloc: _conferenceRegistrationBloc,
          builder: (BuildContext context, ConferenceRegistrationState state) {
            return Scaffold(
              key: _scaffoldKey,
              appBar: AppBar(
                title: const Text('Đăng ký tham dự hội nghị'),
                automaticallyImplyLeading: false,
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.clear),
                    color: Colors.white,
                    onPressed: () => Navigator.pop(context)
                  )
                ],
                centerTitle: true
              ),
              body: LoadingOverlay(
                isLoading: state is ConferenceRegistrationLoading,
                child: Container(
                  color: Colors.white,
                  child: _buildContentWidget(state)
                )
              )
            );
          }
        )
      )
    );
  }

  Widget _buildContentWidget(ConferenceRegistrationState state) {
    if (state is ConferenceRegistrationDataSuccess) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildMembershipWidget(state),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 23.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Text('Đăng ký cho', style: TextStyles.textStyle14PrimaryBlack),
                              ),
                              const SizedBox(width: 5.0),
                              Text('Giá', style: TextStyles.textStyle14PrimaryBlack),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  'Hoi Nghi Khoa Hoc Thuong Nien',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyles.textStyle20PrimaryBlack),
                              ),
                              const SizedBox(width: 5.0),
                              Text(
                                '${CurrencyUtils.formatAsCurrency(state.selectedConferenceFee.fee)} VND',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyles.textStyle16PrimaryBlackBold),
                            ],
                          )
                        ],
                      )
                    ),
                    const Divider(),
                    const SizedBox(height: 23.0),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 28.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text('Chọn loại thư mời', style: TextStyles.textStyle14PrimaryGrey)
                        ],
                      )
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 28.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: widget.conferenceFees.map((ConferenceFee conferenceFee) => Container(
                          transform: Matrix4.translationValues(-17.0, 0.0, 0.0),
                          child: Row(
                            children: <Widget>[
                              Radio<ConferenceFee>(
                                value: conferenceFee,
                                groupValue: state.selectedConferenceFee,
                                onChanged: _handleChangeLetterType,
                              ),
                              InkWell(
                                child: Text(conferenceFee.letterType == 'Email' ? 'Thư điện tử' : 'Thư in đẹp', style: TextStyles.textStyle16PrimaryBlack),
                                onTap: () => _handleChangeLetterType(conferenceFee)
                              )
                            ],
                          )
                        )).toList()
                      )
                    ),
                    const SizedBox(height: 23.0),
                    const Divider(),
                    Promotion(),
                  ]
                )
              )
            ),
          ),
          Container(
            height: 10.0,
            color: AppColors.backgroundConferenceColor
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 24.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Thành Tiền',
                    style: TextStyles.textStyle14PrimaryBlackBold
                  )
                ),
                Text(
                  '${CurrencyUtils.formatAsCurrency(state.selectedConferenceFee.fee)} VND',
                  style: TextStyles.textStyle22PrimaryBlueBold
                )
              ],
            )
          ),
          Container(
            height: 10.0,
            color: AppColors.backgroundConferenceColor,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(top: BorderSide(width: 1.0, color: AppColors.editTextFieldBorderColor)),
              color: Colors.white,
            ),
            padding: const EdgeInsets.only(left: 25.0, top: 28.5, bottom: 28.5, right: 25.0),
            child: PrimaryButton(
              text: 'Tiếp tục',
              onPressed: () => _handleProcessPayment(state.selectedConferenceFee.fee)
            )
          )
        ],
      );
    }

    return Container();
  }

  void _handleChangeLetterType(ConferenceFee conferenceFee) {
    _conferenceRegistrationBloc.dispatch(ConferenceRegistrationDataEvent(widget.conference,
        widget.conferenceFees, selectedConferenceFee: conferenceFee));
  }

  Container _buildMembershipWidget(ConferenceRegistrationDataSuccess state) {
    if (state.premiumMembership) {
      return Container(
        height: 66.0,
        color: AppColors.lightOpacityPrimaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SvgIcon(AppAssets.diamondIcon, size: 28.0),
                const SizedBox(width: 10.0),
                Text('Hội viên HOSREM', style: TextStyles.textStyle16PrimaryBlue),
              ],
            )

          ],
        )
      );
    }

    return Container(
      height: 66.0,
      color: AppColors.backgroundStandardMember,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Thành viên bình thường', style: TextStyles.textStyle16PrimaryGreyBold)
        ]
      )
    );
  }

  Future<void> _handleProcessPayment(double registrationFee) async {
    await Navigator.push(context, MaterialPageRoute<bool>(
      builder: (BuildContext context) =>
        ConferencePayment(conference: widget.conference, registrationFee: registrationFee))
    );
  }

  @override
  void dispose() {
    _conferenceRegistrationBloc.dispose();
    super.dispose();
  }
}
