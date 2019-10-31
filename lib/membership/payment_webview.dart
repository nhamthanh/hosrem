import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

/// Payment webview.
class PaymentWebview extends StatefulWidget {
  const PaymentWebview(this.atm, this.url, { Key key }) : super(key: key);

  final bool atm;
  final String url;

  @override
  _PaymentWebviewState createState() => _PaymentWebviewState();
}

class _PaymentWebviewState extends State<PaymentWebview> {
  @override
  void initState() {
    super.initState();

    final FlutterWebviewPlugin flutterWebviewPlugin = FlutterWebviewPlugin();
    flutterWebviewPlugin.onUrlChanged.listen((String url) {
      print(url);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: !widget.atm
        ? 'https://mtf.onepay.vn/vpcpay/vpcpay.op?vpc_Amount=100&vpc_SHIP_City=Ha+Noi&vpc_Version=2&vpc_OrderInfo=Ma+Don+Hang&vpc_Command=pay&vpc_Customer_Email=thanhvt%40onepay.vn&vpc_Merchant=TESTONEPAY&Title=PHP+VPC+3-Party&vpc_SHIP_Provice=Hoan+Kiem&vpc_Customer_Id=thanhvt&vpc_ReturnURL=http%3A%2F%2Flocalhost%3A8080%2Fquocte%2FVPC_JSP_3P_DR.jsp&AVS_StateProv=Hoan+Kiem&AVS_City=Hanoi&vpc_Customer_Phone=840904280949&AgainLink=http%3A%2F%2Flocalhost%3A8080%2F&vpc_SecureHash=18C3ECC0B044FCB9D46E88B3A049F9B198424034FA8D06D8670DAE97DE01C2FF&vpc_AccessCode=6BEB2546&vpc_MerchTxnRef=TEST_1571913221108-2092042310&vpc_TicketNo=0%3A0%3A0%3A0%3A0%3A0%3A0%3A1&vpc_SHIP_Street01=39A+Ngo+Quyen&vpc_SHIP_Country=Viet+Nam&vpc_Locale=en&AVS_Street01=194+Tran+Quang+Khai&AVS_PostCode=10000'
        : 'https://mtf.onepay.vn/onecomm-pay/vpc.op?vpc_Amount=100&vpc_SHIP_City=Ha+Noi&vpc_Version=2&vpc_OrderInfo=Ma+Don+Hang&vpc_Command=pay&vpc_Currency=VND&vpc_Customer_Email=thanhvt%40onepay.vn&vpc_Merchant=ONEPAY&Title=JSP+VPC+3-Party&vpc_SHIP_Provice=Hoan+Kiem&vpc_Customer_Id=thanhvt&vpc_ReturnURL=http%3A%2F%2Flocalhost%3A8080%2Fnoidia%2Fdr.jsp&vpc_Customer_Phone=840904280949&AgainLink=http%3A%2F%2Flocalhost%3A8080%2F&vpc_SecureHash=65E214BE12534B13336B1F4D3985A7FDB45646154845A978AC914E2A396076F9&vpc_AccessCode=D67342C2&vpc_MerchTxnRef=TEST_15719314980191353438041&vpc_TicketNo=0%3A0%3A0%3A0%3A0%3A0%3A0%3A1&vpc_SHIP_Street01=39A+Ngo+Quyen&vpc_SHIP_Country=Viet+Nam&vpc_Locale=vn',
      appBar: AppBar(
        title: const Text(''),
        centerTitle: true
      )
    );
  }
}
