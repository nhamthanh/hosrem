import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:hosrem_app/common/app_colors.dart';
import 'package:hosrem_app/common/text_styles.dart';

/// Connection provider.
@immutable
class ConnectionProvider extends StatefulWidget {
  const ConnectionProvider({ @required this.child });

  final Widget child;

  @override
  _ConnectionProviderState createState() => _ConnectionProviderState();
}

class _ConnectionProviderState extends State<ConnectionProvider> with SingleTickerProviderStateMixin {

  StreamSubscription<ConnectivityResult> _subscription;
  bool hasInternetConnection = true;

  @override
  void initState() {
    super.initState();
    (Connectivity().checkConnectivity()).then((ConnectivityResult result) {
      setState(() {
        hasInternetConnection = result != ConnectivityResult.none;
      });
    });

    _subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        hasInternetConnection = result != ConnectivityResult.none;
      });
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        hasInternetConnection ? Container() : Container(
          height: 70.0,
          color: AppColors.noInternetBgColor,
          child: Center(
            child: const Text(
              'Vui lòng kiểm tra kết nối internet',
              style: TextStyles.textStyle14PrimaryWhite
            )
          )
        ),
        Expanded(
          child: widget.child,
        )
      ],
    );
  }
}
