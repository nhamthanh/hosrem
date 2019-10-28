import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosrem_app/api/auth/user.dart';
import 'package:hosrem_app/api/membership/membership.dart';
import 'package:hosrem_app/api/payment/payment_type.dart';
import 'package:hosrem_app/common/app_assets.dart';
import 'package:hosrem_app/common/app_colors.dart';
import 'package:hosrem_app/common/base_state.dart';
import 'package:hosrem_app/common/currency_utils.dart';
import 'package:hosrem_app/common/text_styles.dart';
import 'package:hosrem_app/widget/button/primary_button.dart';
import 'package:loading_overlay/loading_overlay.dart';

import 'bloc/membership_payment_bloc.dart';
import 'bloc/membership_payment_event.dart';
import 'bloc/membership_payment_state.dart';
import 'bloc/membership_state.dart';
import 'momo_payment.dart';
import 'payment_methods.dart';
import 'payment_service.dart';
import 'payment_webview.dart';

/// Membership payment page.
@immutable
class MembershipPayment extends StatefulWidget {
  const MembershipPayment({this.user, this.membership});

  final User user;
  final Membership membership;

  @override
  State<MembershipPayment> createState() => _MembershipPaymentState();
}

class _MembershipPaymentState extends BaseState<MembershipPayment> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  MembershipPaymentBloc _membershipPaymentBloc;
  List<PaymentType> _paymentTypes;
  String _selectedPayment;
  MomoPayment _momoPayment;

  @override
  void initState() {
    super.initState();

    _momoPayment = MomoPayment(apiConfig, apiProvider, _handleMomoCallback);
    _membershipPaymentBloc = MembershipPaymentBloc(paymentService: PaymentService(apiProvider));
    _membershipPaymentBloc.dispatch(LoadPaymentDataEvent());
  }

  void _handleMomoCallback(Map<String, dynamic> result) {
    result.putIfAbsent('amount', () => widget.membership.fee);
    print(json.encode(result));
    if (result['status'] == '0') {
      _membershipPaymentBloc.dispatch(ProcessMomoPaymentEvent(
        membership: widget.membership,
        detail: result,
        paymentType: _paymentTypes.firstWhere((PaymentType paymentType) => paymentType.type == PaymentMethods.momo,
          orElse: () => PaymentType.fromJson(<String, dynamic>{}))
      ));
    } else {
      _showPaymentFailDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MembershipPaymentBloc>(
      builder: (BuildContext context) => _membershipPaymentBloc,
      child: BlocListener<MembershipPaymentBloc, MembershipPaymentState>(
        listener: (BuildContext context, MembershipPaymentState state) {
          if (state is MembershipPaymentFailure) {
            _showPaymentFailDialog();
          }

          if (state is MembershipPaymentSuccess) {
            _showPaymentSuccessDialog();
          }
        },
        child: BlocBuilder<MembershipPaymentBloc, MembershipPaymentState>(
          bloc: _membershipPaymentBloc,
          builder: (BuildContext context, MembershipPaymentState state) {
            return Scaffold(
              key: _scaffoldKey,
              appBar: AppBar(
                title: const Text('Thanh Toán'),
                centerTitle: true
              ),
              body: LoadingOverlay(
                isLoading: state is MembershipLoading,
                child: _buildMembershipPaymentWidget(state)
              )
            );
          }
        )
      )
    );
  }

  Widget _buildMembershipPaymentWidget(MembershipPaymentState state) {
    if (state is LoadedPaymentData) {
      _selectedPayment = state.selectedPayment;
      _paymentTypes = state.paymentTypes;
    }

    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(top: 28.0, left: 28.0, right: 28.0, bottom: 16.0),
                          child: Text('Hình thức thanh toán', style: TextStyles.textStyle14PrimaryGrey)
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 15.0, right: 28.0, bottom: 28.0),
                          child: Column(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Radio<String>(
                                        value: PaymentMethods.atm,
                                        groupValue: _selectedPayment,
                                        onChanged: _handleOptionChanged,
                                      ),
                                      Expanded(
                                        child: InkWell(
                                          child: Text('ATM Card', style: TextStyles.textStyle16PrimaryBlack),
                                          onTap: () => _handleOptionChanged(PaymentMethods.atm)
                                        )

                                      ),
                                      Image.asset(AppAssets.atmIcon, width: 46.0, height: 30.0)
                                    ],
                                  )
                                ]
                              ),
                              Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Radio<String>(
                                        value: PaymentMethods.creditCards,
                                        groupValue: _selectedPayment,
                                        onChanged: _handleOptionChanged,
                                      ),
                                      Expanded(
                                        child: InkWell(
                                          child: Text('Thẻ quốc tế (Visa, Master)', style: TextStyles.textStyle16PrimaryBlack),
                                          onTap: () => _handleOptionChanged(PaymentMethods.creditCards)
                                        )
                                      ),
                                      Image.asset(AppAssets.visaIcon, width: 55.0, height: 17.0),
                                      const SizedBox(width: 5.0),
                                      Image.asset(AppAssets.mastercardIcon, width: 49.0, height: 30.0)
                                    ],
                                  )
                                ]
                              ),
                              Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Radio<String>(
                                        value: PaymentMethods.momo,
                                        groupValue: _selectedPayment,
                                        onChanged: _handleOptionChanged,
                                      ),
                                      Expanded(
                                        child: InkWell(
                                          child: Text('Momo', style: TextStyles.textStyle16PrimaryBlack),
                                          onTap: () => _handleOptionChanged(PaymentMethods.momo)
                                        )
                                      ),
                                      Image.asset(AppAssets.momoIcon, width: 80.0, height: 52.0)
                                    ],
                                  )
                                ]
                              )
                            ],
                          )
                        )
                      ],
                    ),
                  ]
                )
              )
            ),
          ),
          Container(
            height: 10.0,
            color: AppColors.backgroundConferenceColor,
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
                  '${CurrencyUtils.formatAsCurrency(widget.membership.fee)} VND',
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
              text: 'Tiến hành thanh toán',
              onPressed: _selectedPayment == null ? null : _handleProcessPayment,
            )
          )
        ]
      )
    );
  }

  void _handleOptionChanged(String payment) {
    _membershipPaymentBloc.dispatch(ChangePaymentMethodEvent(paymentTypes: _paymentTypes,
      selectedPayment: payment));
  }

  Future<void> _handleProcessPayment() async {
    if (_selectedPayment == PaymentMethods.momo) {
      await _momoPayment.requestPayment(widget.membership.fee, 'Đăng ký hội viên HOSREM');
    } else if (_selectedPayment == PaymentMethods.creditCards) {
      await Navigator.push(context, MaterialPageRoute<bool>(
        builder: (BuildContext context) => const PaymentWebview(atm: false))
      );
    } else {
      await Navigator.push(context, MaterialPageRoute<bool>(
        builder: (BuildContext context) => const PaymentWebview(atm: true))
      );
    }
  }

  void _showPaymentFailDialog() {
    showAlert(
      context: context,
      body: 'Thanh toán không thành công. Vui lòng lòng thử lại.',
      actions: <AlertAction>[
        AlertAction(text: 'OK', onPressed: () {
          Navigator.pop(context);
          Navigator.pop(context);
        })
      ]
    );
  }

  void _showPaymentSuccessDialog() {
    showAlert(
      context: context,
      body: 'Tài khoản của bạn đã được nâng cấp thành hội viên HOSREM',
      actions: <AlertAction>[
        AlertAction(text: 'OK', onPressed: () {
          Navigator.pop(context);
          Navigator.pop(context);
        })
      ]
    );
  }

  @override
  void dispose() {
    _membershipPaymentBloc.dispose();
    _momoPayment.dispose();
    super.dispose();
  }
}