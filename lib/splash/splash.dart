import 'dart:async';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:hosrem_app/app/app_routes.dart';
import 'package:hosrem_app/common/app_assets.dart';
import 'package:hosrem_app/common/base_state.dart';

/// Splash page.
class Splash extends StatefulWidget {

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends BaseState<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Center(
          child: Image.asset(AppAssets.imageLogo),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _startTimeout();
  }

  Future<void> _handleTimeout() async {
    await router.navigateTo(context, AppRoutes.homeRoute, clearStack: true, transition: TransitionType.fadeIn);
  }

  Future<void> _startTimeout() async {
    final Duration duration = Duration(milliseconds: 400);
    return Timer(duration, _handleTimeout);
  }
}
