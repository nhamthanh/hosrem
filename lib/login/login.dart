
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosrem_app/auth/auth_service.dart';
import 'package:hosrem_app/common/base_state.dart';
import 'package:hosrem_app/login/bloc/login_bloc.dart';
import 'package:hosrem_app/membership/membership_service.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'bloc/login_state.dart';
import 'login_form.dart';

/// Login page.
@immutable
class Login extends StatefulWidget {

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends BaseState<Login> with SingleTickerProviderStateMixin{
  LoginBloc _loginBloc;

  @override
  void initState() {
    super.initState();
    final AuthService authService = AuthService(apiProvider);
    final MembershipService membershipService = MembershipService(apiProvider);
    _loginBloc = LoginBloc(authService: authService, membershipService: membershipService);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<LoginBloc>(
        builder: (BuildContext context) => _loginBloc,
        child: BlocBuilder<LoginBloc, LoginState>(
          bloc: _loginBloc,
          builder: (BuildContext context, LoginState state) {
            return LoadingOverlay(
              child: LoginForm(),
              isLoading: state is LoginLoading
            );
          }
        )
      )
    );
  }

  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }
}
