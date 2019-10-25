import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosrem_app/api/auth/user.dart';
import 'package:hosrem_app/api/membership/membership.dart';
import 'package:hosrem_app/api/membership/user_membership.dart';
import 'package:hosrem_app/common/app_assets.dart';
import 'package:hosrem_app/common/app_colors.dart';
import 'package:hosrem_app/common/base_state.dart';
import 'package:hosrem_app/common/currency_utils.dart';
import 'package:hosrem_app/common/text_styles.dart';
import 'package:hosrem_app/widget/button/primary_button.dart';
import 'package:loading_overlay/loading_overlay.dart';

import 'bloc/membership_bloc.dart';
import 'bloc/membership_event.dart';
import 'bloc/membership_state.dart';
import 'membership_payment.dart';
import 'membership_service.dart';
import 'promotion.dart';

/// Membership registration page.
@immutable
class MembershipRegistration extends StatefulWidget {
  const MembershipRegistration({this.user, this.userMembership});

  final User user;
  final UserMembership userMembership;

  @override
  State<MembershipRegistration> createState() => _MembershipRegistrationState();
}

class _MembershipRegistrationState extends BaseState<MembershipRegistration> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  MembershipBloc _membershipBloc;
  Membership _selectedMembership;
  String _title;

  @override
  void initState() {
    super.initState();

    _title = 'Đăng ký hội viên';
    if (widget.userMembership != null) {
      final DateTime current = DateTime.now().add(Duration(days: 30));
      if (current.isAfter(widget.userMembership.expiredTime)) {
        _title = 'Gia hạn hội viên';
      }
    }

    _membershipBloc = MembershipBloc(membershipService: MembershipService(apiProvider));
    _membershipBloc.dispatch(LoadMembershipEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MembershipBloc>(
      builder: (BuildContext context) => _membershipBloc,
      child: BlocListener<MembershipBloc, MembershipState>(
        listener: (BuildContext context, MembershipState state) {
          if (state is MembershipFailure) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.error}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<MembershipBloc, MembershipState>(
          bloc: _membershipBloc,
          builder: (BuildContext context, MembershipState state) {
            if (state is MembershipSuccess) {
              return Scaffold(
                key: _scaffoldKey,
                appBar: AppBar(
                  title: Text(_title),
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
                  isLoading: state is MembershipLoading,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                        child: SingleChildScrollView(
                          child: Container(
                            color: Colors.white,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.all(28.0),
                                  child: Text(
                                    'Sẵn sàng nâng cấp tài khoản của bạn thành hội viên HOSREM?',
                                    style: TextStyles.textStyle20PrimaryBlack,
                                    textAlign: TextAlign.center,
                                  )
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 12.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: state.memberships.map(
                                        (Membership membership) => _buildMembershipCardWidget(membership, state.memberships)).toList()
                                  )
                                ),
                                const Divider(),
                                Promotion(),
                                const SizedBox(height: 24.0)
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
                              state.selectedMembership == null ? '0 VND' : '${CurrencyUtils.formatAsCurrency(state.selectedMembership.fee)} VND',
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
                          onPressed: state.selectedMembership == null ? null : _handleProcessPayment
                        )
                      )
                    ]
                  )
                )
              );
            }
            return Container();
          }
        )
      )
    );
  }

  Widget _buildMembershipCardWidget(Membership membership, List<Membership> memberships) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        InkWell(
          child: Container(
            height: 139.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              image: DecorationImage(
                image: AssetImage(memberships.indexOf(membership) % 2 == 0 ? AppAssets.cardGreenBg : AppAssets.cardPurpleBg),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Đăng ký ${membership.duration} năm',
                  style: TextStyles.textStyle22PrimaryWhiteBold),
                Text(
                  '${CurrencyUtils.formatAsCurrency(membership.fee)} VND',
                  style: TextStyles.textStyle22PrimaryWhite
                ),
              ],
            ),
          ),
          onTap: () => _handleOptionChanged(membership, memberships)
        ),
        Container(
          transform: Matrix4.translationValues(-17.0, 0.0, 0.0),
          child: Row(
            children: <Widget>[
              Radio<Membership>(
                value: membership,
                groupValue: _selectedMembership,
                onChanged: (Membership membership) => _handleOptionChanged(membership, memberships),
              ),
              Expanded(
                child: InkWell(
                  child: Text('Lựa chọn đăng ký ${membership.duration} năm', style: TextStyles.textStyle16PrimaryBlack),
                  onTap: () => _handleOptionChanged(membership, memberships)
                )
              )
            ],
          )
        ),
        const SizedBox(height: 10.0)
      ],
    );
  }

  void _handleOptionChanged(Membership membership, List<Membership> memberships) {
    _selectedMembership = membership;
    _membershipBloc.dispatch(SelectMembershipEvent(selectedMembership: membership, memberships: memberships));
  }

  Future<void> _handleProcessPayment() async {
    await Navigator.push(context, MaterialPageRoute<bool>(
      builder: (BuildContext context) => MembershipPayment(user: widget.user, membership: _selectedMembership))
    );
  }

  @override
  void dispose() {
    _membershipBloc.dispose();
    super.dispose();
  }
}
