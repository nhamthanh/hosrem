import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosrem_app/api/conference/conference.dart';
import 'package:hosrem_app/api/conference/conference_fee.dart';
import 'package:hosrem_app/api/payment/payment_type.dart';
import 'package:hosrem_app/auth/auth_service.dart';
import 'package:hosrem_app/common/app_assets.dart';
import 'package:hosrem_app/common/app_colors.dart';
import 'package:hosrem_app/common/base_state.dart';
import 'package:hosrem_app/common/currency_utils.dart';
import 'package:hosrem_app/common/text_styles.dart';
import 'package:hosrem_app/conference/bloc/conference_payment_bloc.dart';
import 'package:hosrem_app/conference/bloc/conference_payment_event.dart';
import 'package:hosrem_app/conference/bloc/conference_payment_state.dart';
import 'package:hosrem_app/connection/connection_provider.dart';
import 'package:hosrem_app/membership/momo_payment.dart';
import 'package:hosrem_app/membership/payment_methods.dart';
import 'package:hosrem_app/membership/payment_service.dart';
import 'package:hosrem_app/membership/payment_webview.dart';
import 'package:hosrem_app/widget/button/primary_button.dart';
import 'package:hosrem_app/widget/svg/svg_icon.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../conference_service.dart';

/// Conference registration page.
@immutable
class ConferencePayment extends StatefulWidget {
  const ConferencePayment({Key key, this.conference, this.conferenceFee}) : super(key: key);

  final Conference conference;
  final ConferenceFee conferenceFee;

  @override
  State<ConferencePayment> createState() => _ConferencePaymentState();
}

class _ConferencePaymentState extends BaseState<ConferencePayment> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  ConferencePaymentBloc _conferencePaymentBloc;
  List<PaymentType> _paymentTypes = <PaymentType>[];
  bool _premiumMembership = false;
  String _selectedPaymentMethod;
  MomoPayment _momoPayment;

  @override
  void initState() {
    super.initState();

    _momoPayment = MomoPayment(apiConfig, apiProvider, _handleMomoCallback);
    _conferencePaymentBloc = ConferencePaymentBloc(ConferenceService(apiProvider), AuthService(apiProvider),
        PaymentService(apiProvider));
    _conferencePaymentBloc.dispatch(LoadConferencePaymentDataEvent(widget.conference, widget.conferenceFee.fee));
  }

  void _handleMomoCallback(Map<String, dynamic> result) {
    result.putIfAbsent('amount', () => widget.conferenceFee.fee);
    print(json.encode(result));
    if (result['status'] == '0') {
      final PaymentType paymentType = _paymentTypes.firstWhere((PaymentType paymentType) => paymentType.type == PaymentMethods.momo,
        orElse: () => PaymentType.fromJson(<String, dynamic>{}));

      _conferencePaymentBloc.dispatch(ProcessMomoPaymentEvent(
        result,
        widget.conference.id,
        widget.conferenceFee.fee,
        '71D Lac Long Quan',
        widget.conferenceFee.letterType,
        paymentType
      ));
    } else {
      _showPaymentFailDialog('');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ConferencePaymentBloc>(
      builder: (BuildContext context) => _conferencePaymentBloc,
      child: BlocListener<ConferencePaymentBloc, ConferencePaymentState>(
        listener: (BuildContext context, ConferencePaymentState state) {
          if (state is ConferencePaymentFailure) {
            _showPaymentFailDialog('');
          }

          if (state is ConferencePaymentSuccess) {
            _showPaymentSuccessDialog();
          }

          if (state is ConferenceCreditCardPaymentSuccess) {
            if (state.payment.detail.containsKey('requestUrl')) {
              _navigateToPaymentWebview(state.payment.detail['requestUrl']);
            } else {
              _showPaymentFailDialog('');
            }
          }

          if (state is ConferenceAtmPaymentSuccess) {
            if (state.payment.detail.containsKey('requestUrl')) {
              _navigateToPaymentWebview(state.payment.detail['requestUrl']);
            } else {
              _showPaymentFailDialog('');
            }
          }

          if (state is ConferencePendingPaymentSuccess) {
            showAlert(
              context: context,
              body: 'Cảm ơn bạn đã đăng ký. Vui lòng liên hệ Hosrem để hoàn thành thanh toán.',
              actions: <AlertAction>[
                AlertAction(text: 'OK', onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                })
              ]
            );
          }
        },
        child: BlocBuilder<ConferencePaymentBloc, ConferencePaymentState>(
          bloc: _conferencePaymentBloc,
          builder: (BuildContext context, ConferencePaymentState state) {
            return Scaffold(
              key: _scaffoldKey,
              appBar: AppBar(
                title: const Text('Thanh Toán'),
                centerTitle: true
              ),
              body: ConnectionProvider(
                child: LoadingOverlay(
                  isLoading: state is ConferencePaymentLoading,
                  child: Container(
                    color: Colors.white,
                    child: _buildContentWidget(state)
                  )
                )
              )
            );
          }
        )
      )
    );
  }

  Widget _buildContentWidget(ConferencePaymentState state) {
    if (state is ConferencePaymentDataSuccess) {
      _paymentTypes = state.paymentTypes;
      _selectedPaymentMethod = state.selectedPaymentMethod;
      _premiumMembership = state.premiumMembership;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _buildMembershipWidget(_premiumMembership),
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
                        child: const Text('Hình thức thanh toán', style: TextStyles.textStyle14PrimaryGrey)
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
                                      value: PaymentMethods.onepayAtm,
                                      groupValue: _selectedPaymentMethod,
                                      onChanged: _handleOptionChanged,
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        child: const Text('ATM Card', style: TextStyles.textStyle16PrimaryBlack),
                                        onTap: () => _handleOptionChanged(PaymentMethods.onepayAtm)
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
                                      value: PaymentMethods.onepayCreditCards,
                                      groupValue: _selectedPaymentMethod,
                                      onChanged: _handleOptionChanged,
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        child: const Text('Thẻ quốc tế (Visa, Master)', style: TextStyles.textStyle16PrimaryBlack),
                                        onTap: () => _handleOptionChanged(PaymentMethods.onepayCreditCards)
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
                                      groupValue: _selectedPaymentMethod,
                                      onChanged: _handleOptionChanged,
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        child: const Text('Momo', style: TextStyles.textStyle16PrimaryBlack),
                                        onTap: () => _handleOptionChanged(PaymentMethods.momo)
                                      )
                                    ),
                                    Image.asset(AppAssets.momoIcon, width: 80.0, height: 52.0)
                                  ],
                                )
                              ]
                            ),
                            Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Radio<String>(
                                      value: PaymentMethods.directPayment,
                                      groupValue: _selectedPaymentMethod,
                                      onChanged: _handleOptionChanged,
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        child: const Text('Thanh Toán Trực Tiếp', style: TextStyles.textStyle16PrimaryBlack),
                                        onTap: () => _handleOptionChanged(PaymentMethods.directPayment)
                                      )
                                    ),
                                    Image.asset(AppAssets.cashIcon, width: 80.0, height: 52.0)
                                  ],
                                )
                              ]
                            ),
                            Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Radio<String>(
                                      value: PaymentMethods.bankTransfer,
                                      groupValue: _selectedPaymentMethod,
                                      onChanged: _handleOptionChanged,
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        child: const Text('Chuyển Khoản', style: TextStyles.textStyle16PrimaryBlack),
                                        onTap: () => _handleOptionChanged(PaymentMethods.bankTransfer)
                                      )
                                    ),
                                    Image.asset(AppAssets.bankTransferIcon, width: 80.0, height: 52.0)
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
                '${CurrencyUtils.formatAsCurrency(widget.conferenceFee.fee)} VND',
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
            border: Border(top: const BorderSide(width: 1.0, color: AppColors.editTextFieldBorderColor)),
            color: Colors.white,
          ),
          padding: const EdgeInsets.only(left: 25.0, top: 28.5, bottom: 28.5, right: 25.0),
          child: PrimaryButton(
            text: 'Tiến hành thanh toán',
            onPressed: _selectedPaymentMethod == null ? null : _handleProcessPayment,
          )
        )
      ],
    );
  }

  void _showPaymentSuccessDialog() {
    showAlert(
      context: context,
      body: 'Bạn đã đăng ký tham dự hội nghị thành công',
      actions: <AlertAction>[
        AlertAction(text: 'OK', onPressed: () {
          Navigator.pop(context);
          Navigator.pop(context);
        })
      ]
    );
  }

  void _showPaymentFailDialog(dynamic e) {
    showAlert(
      context: context,
      body: 'Thanh toán không thành công. Vui lòng thử lại.',
      actions: <AlertAction>[
        AlertAction(text: 'OK', onPressed: () {
          Navigator.pop(context);
          Navigator.pop(context);
        })
      ]
    );
  }

  bool _validateSelectedPaymentType(String selectedPaymentName, String selectedPaymentMethod) {
    final PaymentType paymentType = _paymentTypes.firstWhere((PaymentType paymentType) => paymentType.type == selectedPaymentMethod,
      orElse: () => null);

    if (paymentType == null) {
      showAlert(
        context: context,
        body: 'Hiện tại $selectedPaymentName chưa được hỗ trợ. Vui lòng chọn hình thức khác.'
      );
      return false;
    }

    return true;
  }

  Future<void> _handleProcessPayment() async {
    if (_selectedPaymentMethod == PaymentMethods.momo) {
      await _payViaMomo();
    } else if (_selectedPaymentMethod == PaymentMethods.onepayCreditCards) {
      _payViaCreditCardsUsingOnePay();
    } else if (_selectedPaymentMethod == PaymentMethods.onepayAtm) {
      _payViaAtmsUsingOnePay();
    } else if (_selectedPaymentMethod == PaymentMethods.directPayment) {
      _payViaDirectPayment();
    } else {
      _payViaBankTransfer();
    }
  }

  Future<void> _payViaMomo() async {
    if (!_validateSelectedPaymentType('Momo', PaymentMethods.momo)) {
      return;
    }

    await _momoPayment.requestPayment(widget.conferenceFee.fee, 'Đăng ký tham gia hội nghị');
  }

  void _payViaCreditCardsUsingOnePay() {
    if (!_validateSelectedPaymentType('OnePay', PaymentMethods.onepayCreditCards)) {
      return;
    }

    final PaymentType paymentType = _paymentTypes.firstWhere((PaymentType paymentType) => paymentType.type == PaymentMethods.onepayCreditCards,
      orElse: () => PaymentType.fromJson(<String, dynamic>{}));
    _conferencePaymentBloc.dispatch(ProcessCreditCardPaymentEvent(
      <String, dynamic>{
        'amount': widget.conferenceFee.fee,
        'type': 'external'
      },
      widget.conference.id,
      widget.conferenceFee.fee,
      '',
      widget.conferenceFee.letterType,
      paymentType
    ));
  }

  void _payViaDirectPayment() {
    if (!_validateSelectedPaymentType('Thanh toán trực tiếp', PaymentMethods.directPayment)) {
      return;
    }

    final PaymentType paymentType = _paymentTypes.firstWhere((PaymentType paymentType) => paymentType.type == PaymentMethods.directPayment,
      orElse: () => PaymentType.fromJson(<String, dynamic>{}));
    _conferencePaymentBloc.dispatch(ProcessPendingPaymentEvent(
      <String, dynamic>{
        'amount': widget.conferenceFee.fee
      },
      widget.conference.id,
      widget.conferenceFee.fee,
      '',
      widget.conferenceFee.letterType,
      paymentType
    ));
  }

  void _payViaBankTransfer() {
    if (!_validateSelectedPaymentType('Chuyển khoản', PaymentMethods.bankTransfer)) {
      return;
    }

    final PaymentType paymentType = _paymentTypes.firstWhere((PaymentType paymentType) => paymentType.type == PaymentMethods.bankTransfer,
      orElse: () => PaymentType.fromJson(<String, dynamic>{}));
    _conferencePaymentBloc.dispatch(ProcessPendingPaymentEvent(
      <String, dynamic>{
        'amount': widget.conferenceFee.fee
      },
      widget.conference.id,
      widget.conferenceFee.fee,
      '',
      widget.conferenceFee.letterType,
      paymentType
    ));
  }

  void _payViaAtmsUsingOnePay() {
    if (!_validateSelectedPaymentType('OnePay', PaymentMethods.onepayAtm)) {
      return;
    }

    final PaymentType paymentType = _paymentTypes.firstWhere((PaymentType paymentType) => paymentType.type == PaymentMethods.onepayAtm,
      orElse: () => PaymentType.fromJson(<String, dynamic>{}));
    _conferencePaymentBloc.dispatch(ProcessAtmPaymentEvent(
      <String, dynamic>{
        'amount': widget.conferenceFee.fee,
        'type': 'internal'
      },
      widget.conference.id,
      widget.conferenceFee.fee,
      '',
      widget.conferenceFee.letterType,
      paymentType
    ));
  }

  void _handleOptionChanged(String paymentMethod) {
    _conferencePaymentBloc.dispatch(ChangePaymentMethodEvent(_paymentTypes, widget.conferenceFee.fee, _premiumMembership,
      selectedPaymentMethod: paymentMethod));
  }

  Container _buildMembershipWidget(bool premiumMembership) {
    if (premiumMembership) {
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

  void _navigateToPaymentWebview(String url) {
    Navigator.push(context, MaterialPageRoute<bool>(
      builder: (BuildContext context) => PaymentWebview(true, url))
    ).then((bool result) {
      if (result) {
        _showPaymentSuccessDialog();
      } else {
        _showPaymentFailDialog('');
      }
    }, onError: _showPaymentFailDialog);
  }

  @override
  void dispose() {
    _conferencePaymentBloc.dispose();
    super.dispose();
  }
}
