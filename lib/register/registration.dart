import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosrem_app/auth/auth_service.dart';
import 'package:hosrem_app/register/bloc/registration_bloc.dart';

import 'package:loading_overlay/loading_overlay.dart';
import 'bloc/registration_state.dart';
import 'registration_form.dart';

/// Register page.
class Registration extends StatefulWidget {
  const Registration({Key key, @required this.authService})
      : assert(authService != null),
        super(key: key);

  final AuthService authService;

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  RegistrationBloc _registrationBloc;

  @override
  void initState() {
    _registrationBloc = RegistrationBloc(authService: widget.authService);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<RegistrationBloc>(
        builder: (BuildContext context) => _registrationBloc,
        child: BlocBuilder<RegistrationBloc, RegistrationState>(
          bloc: _registrationBloc,
          builder: (BuildContext context, RegistrationState state) {
            return LoadingOverlay(child: RegistrationForm(), isLoading: state is RegistrationLoading);
          }
        )
      )
    );
  }

  @override
  void dispose() {
    _registrationBloc.dispose();
    super.dispose();
  }
}
