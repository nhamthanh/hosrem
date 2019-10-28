import 'package:flutter/material.dart';
import 'package:hosrem_app/common/app_assets.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

/// Conference QR Code.
@immutable
class ConferenceQrCode extends StatelessWidget {
  const ConferenceQrCode({Key key, @required this.qrCode}) : assert(qrCode != null), super(key: key);

  final String qrCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mã Tham Dự Hội Nghị')
      ),
      body: Center(
        child: PrettyQr(
          image: AssetImage(AppAssets.imageLogo),
          typeNumber: 3,
          size: 300,
          data: qrCode,
          roundEdges: true
        )
      )
    );
  }
}