import 'dart:async';

import 'package:hosrem_app/config/api_config.dart';
import 'package:hosrem_app/network/api_provider.dart';
import 'package:momo/momo.dart';

/// Momo payment.
class MomoPayment {
  MomoPayment(this.apiConfig, this.apiProvider, this.momoCallback) {
    _momo = Momo();
    _momo.setEnvironment('dev');

    _streamSubscription = _momo.onMomoCallback().listen((Map<String, dynamic> result) async {
      print('onMomoCallback()...');
      print(result);
      momoCallback(result);
    });
  }

  final ApiProvider apiProvider;
  final ApiConfig apiConfig;
  final Function(Map<String, dynamic> result) momoCallback;

  Momo _momo;
  StreamSubscription<Map<String, dynamic>> _streamSubscription;

  /// Request a payment with [amount], [description] to Momo to get payment token.
  Future<void> requestPayment(double amount, String description) async {
    final String orderId = DateTime.now().millisecondsSinceEpoch.toString();
    await _momo.requestPayment(<String, dynamic>{
      'merchantName': apiConfig.momoMerchantName,
      'merchantCode': apiConfig.momoPartnerCode,
      'amount': amount,
      'orderId': orderId,
      'orderLabel': 'Mã đơn hàng',
      'fee': 0.0,
      'description': description,
      'merchantNameLabel': 'Nhà cung cấp',
      'requestId': '1',
      'partnerCode': apiConfig.momoPartnerCode,
      'extraData': '',
      'language': 'vi',
      'extra': '',
      'appScheme': apiConfig.momoAppScheme
    });
  }

  /// Dispose momo payment.
  void dispose() {
    _streamSubscription.cancel();
  }
}
