import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:logging/logging.dart';

/// Payment webview.
class PaymentWebview extends StatefulWidget {
  const PaymentWebview(this.atm, this.url, { Key key }) : super(key: key);

  final bool atm;
  final String url;

  @override
  _PaymentWebviewState createState() => _PaymentWebviewState();
}

class _PaymentWebviewState extends State<PaymentWebview> {

  String _callbackUrl;

  final Logger _logger = Logger('PaymentWebview');

  @override
  void initState() {
    super.initState();
    final Uri uri = Uri.parse(widget.url);
    _callbackUrl = uri.queryParameters['vpc_ReturnURL'];
    _logger.info('Callback URL $_callbackUrl');

    final FlutterWebviewPlugin flutterWebviewPlugin = FlutterWebviewPlugin();
    flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged state) {
      _logger.info(state.type);
      _logger.info(state.url);
      if (state.type == WebViewState.finishLoad) {
        if (state.url.startsWith(_callbackUrl)) {
          final Uri callbackUri = Uri.parse(state.url);
          final String responseCode = callbackUri.queryParameters['vpc_TxnResponseCode'];
          Navigator.pop(context, responseCode == '0');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: widget.url,
      appBar: AppBar(
        title: const Text(''),
        centerTitle: true
      )
    );
  }
}
