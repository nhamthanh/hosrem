import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosrem_app/auth/auth_service.dart';

import 'package:hosrem_app/common/app_colors.dart';
import 'package:hosrem_app/common/base_state.dart';
import 'package:hosrem_app/common/text_styles.dart';
import 'package:hosrem_app/connection/connection_provider.dart';
import 'package:hosrem_app/membership/membership_service.dart';
import 'package:hosrem_app/notification/notification_service.dart';
import 'package:hosrem_app/profile/profile_change_password.dart';
import 'package:hosrem_app/register/registration_form.dart';
import 'package:hosrem_app/auth/registration_success.dart' as registration_success_page;
import 'package:loading_overlay/loading_overlay.dart';

import 'package:hosrem_app/auth/login_form.dart';

import 'bloc/auth_bloc.dart';
import 'bloc/auth_event.dart';
import 'bloc/auth_state.dart';


/// Login register page.
@immutable
class LoginRegistration extends StatefulWidget {
  @override
  State<LoginRegistration> createState() => _LoginRegistrationState();
}

class _LoginRegistrationState extends BaseState<LoginRegistration> with SingleTickerProviderStateMixin {
  
  final List<Widget> _tabs = <Widget>[
    Container(child: const Tab(text: 'Đăng Nhập'), width: 130.0, height: 36),
    Container(child: const Tab(text: 'Đăng Ký'), width: 130.0, height: 36),
  ];

  TabController _tabController;
  AuthBloc _authBloc;
  int _selectedTabIndex = 0;
  bool _checkedAgreement = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Login form
  final TextEditingController _emailPhoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Registration form
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: _tabs.length);
    _tabController.addListener(() => setState(() => _selectedTabIndex = _tabController.index));

    final AuthService authService = AuthService(apiProvider);
    final MembershipService membershipService = MembershipService(apiProvider);
    final NotificationService notificationService = NotificationService(apiProvider);
    _authBloc = AuthBloc(authService: authService, membershipService: membershipService,
        notificationService: notificationService);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _authBloc.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      builder: (BuildContext context) => _authBloc,
      child: BlocListener<AuthBloc, AuthState>(
        listener: (BuildContext context, AuthState state) async {
          if (state is LoginSuccess) {
            if (state.user.mustResetPassword) {
              await Navigator.push(context, MaterialPageRoute<bool>(builder: (BuildContext context) => ChangePasswordForm(state.user)));
              Navigator.pop(context, true);
            } else {
              Navigator.pop(context, true);
            }
          }

          if (state is LoginFailure) {
            _scaffoldKey.currentState.showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.red,
              ),
            );
          }

          if (state is RegistrationValidationState) {
            if (state.validFullName && state.validEmail && state.validPhone &&
              state.validPassword && !state.checked) {
              _checkedAgreement = false;
              _scaffoldKey.currentState.showSnackBar(
                SnackBar(
                  content: Text(AppLocalizations.of(context).tr('registration.please_confirm')),
                  backgroundColor: Colors.red,
                ),
              );
            }
          }

          if (state is RegistrationSuccess) {
            _scaffoldKey.currentState.hideCurrentSnackBar();
            final bool result = await pushWidgetWithBoolResult(registration_success_page.RegistrationSuccess());
            if (result) {
              _authBloc.dispatch(CleanRegistrationEvent());
              _tabController.animateTo(0);
            }
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          bloc: _authBloc,
          builder: (BuildContext context, AuthState state) {
            return LoadingOverlay(
              isLoading: state is LoginLoading,
              child: Scaffold(
                key: _scaffoldKey,
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                  automaticallyImplyLeading: false,
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(Icons.clear),
                      color: AppColors.primaryGreyColor,
                      onPressed: () => Navigator.pop(context)
                    )
                  ],
                  centerTitle: true
                ),
                body: ConnectionProvider(
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                const SizedBox(height: 10.5),
                                Row(
                                  children: <Widget> [
                                    Expanded(child : Text(
                                      AppLocalizations.of(context).tr('login.welcome'),
                                      textAlign: TextAlign.center,
                                      style: TextStyles.textStyle32SecondaryGrey
                                    )),
                                  ]
                                ),
                                Row(
                                  children: <Widget> [
                                    Expanded(child : Text(
                                      AppLocalizations.of(context).tr('login.hosrem'),
                                      textAlign: TextAlign.center,
                                      style: TextStyles.textStyle40PrimaryBlueBold
                                    )),
                                  ]
                                ),
                                const SizedBox(height: 20.5),
                                const Divider(),
                                const SizedBox(height: 20.0),
                                _buildTabBar(),
                                const SizedBox(height: 20.0),
                                Container(
                                  height: 500.0,
                                  color: Colors.white,
                                  child: TabBarView(
                                    controller: _tabController,
                                    children: <Widget>[
                                      _buildLoginForm(state),
                                      _buildRegistrationForm(state)
                                    ]
                                  )
                                ),
                              ],
                            )
                          )
                        ),
                        
                      ]
                    ),
                  )
                )
              )
            );
          }
        )
      )
    );
  }

  Widget _buildRegistrationForm(AuthState state) {
    if (state is RegistrationValidationState) {
      return RegistrationForm(
        _fullNameController,
        _emailController,
        _phoneController,
        _pwController,
        _handleRegisterClick,
          (bool checked) => _checkedAgreement = checked,
        validEmail: state.validEmail,
        validFullName: state.validFullName,
        validPhone: state.validPhone,
        validPassword: state.validPassword,
        checked: _checkedAgreement
      );
    }

    if (state is RegistrationCleanState) {
      _fullNameController.text = '';
      _emailController.text = '';
      _phoneController.text = '';
      _pwController.text = '';
      _checkedAgreement = false;
    }

    return RegistrationForm(_fullNameController, _emailController, _phoneController,
      _pwController, _handleRegisterClick, (bool checked) => _checkedAgreement = checked, checked: _checkedAgreement);
  }

  Widget _buildLoginForm(AuthState state) {
    if (state is LoginValidationState) {
      return LoginForm(
        _emailPhoneController,
        _passwordController,
        _handleLoginClick,
        validEmail: state.validEmail,
        validPassword: state.validPassword
      );
    }
    return LoginForm(_emailPhoneController, _passwordController, _handleLoginClick);
  }

  void _handleLoginClick() {
    _authBloc.dispatch(LoginButtonPressed(email: _emailPhoneController.text, password: _passwordController.text));
  }

  void _handleRegisterClick() {
    _authBloc.dispatch(RegisterButtonPressed(
      email: _emailController.text,
      password: _pwController.text,
      phone: _phoneController.text,
      fullName: _fullNameController.text,
      checked: _checkedAgreement
    ));
  }

  TabBar _buildTabBar() {
    return TabBar(
      isScrollable: true,
      unselectedLabelColor: AppColors.unselectLabelColor,
      labelStyle: TextStyles.textStyle16,
      unselectedLabelStyle: TextStyles.textStyle16,
      labelColor: Colors.white,
      indicatorSize: TabBarIndicatorSize.tab,
      indicator: BubbleTabIndicator(
        indicatorHeight: 36.0,
        indicatorColor: AppColors.lightPrimaryColor,
        indicatorRadius: 20.0,
        tabBarIndicatorSize: TabBarIndicatorSize.tab,
      ),
      tabs: _tabs,
      controller: _tabController
    );
  }
}
