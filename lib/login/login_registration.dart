import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hosrem_app/auth/auth_service.dart';
import 'package:hosrem_app/common/app_colors.dart';
import 'package:hosrem_app/common/base_state.dart';
import 'package:hosrem_app/common/text_styles.dart';
import 'package:hosrem_app/login/login.dart';
import 'package:hosrem_app/register/registration.dart';




/// Login register page.
@immutable
class LoginRegister extends StatefulWidget {
  const LoginRegister({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginRegisterState createState() => _LoginRegisterState();
}

class _LoginRegisterState extends BaseState<LoginRegister> with SingleTickerProviderStateMixin {

  final List<Widget> tabs = <Widget>[
    Container(child: const Tab(text: 'Đăng nhập'), width: 130.0, height: 36,),
    Container(child: const Tab(text: 'Đăng ký'), width: 130.0, height: 36,),
  ];

  TabController _tabController;
  AuthService authService;


  @override
  void initState() {
    super.initState();
    authService = AuthService(apiProvider);
    _tabController = TabController(vsync: this, length: tabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            const SizedBox(height: 9.0),
            Row(
              children: <Widget> [
                Expanded(child : IconButton(
                  alignment: Alignment.bottomRight,
                  icon: Icon(Icons.clear),
                  color: AppColors.primaryGreyColor,
                  onPressed: () => Navigator.pop(context)
              )),
              ]
            ),
            const SizedBox(height: 35.0),
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
            const SizedBox(height: 20),
            Row(
              children: const <Widget> [
                Expanded(child : Divider()),
              ]
            ),
            const SizedBox(height: 25),
            _buildTabBar(),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                color: Colors.white,
                child: TabBarView(
                  controller: _tabController,
                  children: <Widget>[
                    Login(),
                    Registration(authService: authService),
                  ]
                )
              )
            )
          ]
        ),
      )
    );
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
      tabs: tabs,
      controller: _tabController
    );
  }
}