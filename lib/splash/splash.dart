import 'dart:async';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosrem_app/app/app_context.dart';
import 'package:hosrem_app/app/app_routes.dart';
import 'package:hosrem_app/app/bloc/app_bloc.dart';
import 'package:hosrem_app/auth/auth_service.dart';
import 'package:hosrem_app/common/app_assets.dart';

/// Splash page.
class Splash extends StatefulWidget {

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  AuthService _authService;
  Router _router;

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
    final AppContext appContext = BlocProvider.of<AppBloc>(context).appContext;

    _router = appContext.router;
    _authService = AuthService(appContext.apiProvider);

    _startTimeout();
  }

  Future<void> handleTimeout() async {
    final bool hasToken = await _authService.hasToken();
    await _router.navigateTo(
      context,
      hasToken ? AppRoutes.homeRoute : AppRoutes.loginRoute,
      clearStack: true,
      transition: TransitionType.fadeIn
    );
  }

  Future<void> _startTimeout() async {
    final Duration duration = Duration(milliseconds: 500);
    return Timer(duration, handleTimeout);
  }
}
