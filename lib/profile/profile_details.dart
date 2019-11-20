import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosrem_app/api/auth/degree.dart';
import 'package:hosrem_app/api/auth/field.dart';
import 'package:hosrem_app/api/auth/user.dart';
import 'package:hosrem_app/auth/auth_service.dart';
import 'package:hosrem_app/common/app_assets.dart';
import 'package:hosrem_app/common/app_colors.dart';
import 'package:hosrem_app/common/base_state.dart';
import 'package:hosrem_app/common/date_time_utils.dart';
import 'package:hosrem_app/widget/svg/svg_icon.dart';
import 'package:hosrem_app/widget/text/static_multiple_text_field.dart';
import 'package:hosrem_app/widget/text/static_text_field.dart';
import 'package:loading_overlay/loading_overlay.dart';

import 'bloc/profile_bloc.dart';
import 'bloc/profile_event.dart';
import 'bloc/profile_state.dart';
import 'update_profile.dart';

/// Profile details page.
@immutable
class ProfileDetails extends StatefulWidget {
  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends BaseState<ProfileDetails> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  ProfileBloc _profileBloc;
  User _user;

  @override
  void initState() {
    super.initState();

    _profileBloc = ProfileBloc(authService: AuthService(apiProvider));
    _profileBloc.dispatch(LoadProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileBloc>(
      builder: (BuildContext context) => _profileBloc,
      child: BlocListener<ProfileBloc, ProfileState>(
        listener: (BuildContext context, ProfileState state) {
          if (state is ProfileFailure) {
            _scaffoldKey.currentState.showSnackBar(
              SnackBar(
                content: Text('${state.error}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<ProfileBloc, ProfileState>(
          bloc: _profileBloc,
          builder: (BuildContext context, ProfileState state) {
            if (state is ProfileSuccess) {
              _user = state.user;
            }

            return Scaffold(
              key: _scaffoldKey,
              appBar: AppBar(
                title: Text(AppLocalizations.of(context).tr('my_profile.my_profile')),
                actions: <Widget>[
                  FlatButton(
                    textColor: Colors.white,
                    onPressed: _navigateToUpdateProfile,
                    child: SvgIcon(AppAssets.pencil, size: 23.3, color: Colors.white),
                    shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
                  ),
                ],
                centerTitle: true
              ),
              body: LoadingOverlay(
                isLoading: state is ProfileLoading,
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 26.0, horizontal: 28.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        StaticTextField('Tên Hội Viên', _user?.fullName),
                        const SizedBox(height: 16.0),
                        StaticTextField(
                          'Ngày Tháng Năm Sinh',
                          _user?.dob != null ? DateTimeUtils.formatAsStandard(_user?.dob) : ''
                        ),
                        const SizedBox(height: 16.0),
                        StaticTextField('Đơn vị công tác', _user?.company),
                        const SizedBox(height: 16.0),
                        StaticTextField('Chức vụ', _user?.position),
                        const SizedBox(height: 16.0),
                        StaticTextField('Học vị', _user?.degrees?.map((Degree degree) => degree.name)?.join(',')),
                        const SizedBox(height: 16.0),
                        Container(
                          height: 20.0,
                          color: AppColors.backgroundConferenceColor,
                        ),
                        StaticMultipleTextField(
                          'Lĩnh vực quan tâm',
                          _user?.fields?.map((Field field) => field.name)?.toList() ?? <String>[]
                        ),
                        const SizedBox(height: 16.0),
                        Container(
                          height: 20.0,
                          color: AppColors.backgroundConferenceColor,
                        ),
                        StaticTextField('Địa chỉ', _user?.address),
                        const SizedBox(height: 16.0),
                        StaticTextField('Email', _user?.email),
                        const SizedBox(height: 16.0),
                      ]
                    )
                  )
                )
              )
            );
          }
        )
      )
    );
  }

  Future<void> _navigateToUpdateProfile() async {
    await pushWidget(UpdateProfile());
    _profileBloc.dispatch(LoadProfileEvent());
  }

  @override
  void dispose() {
    _profileBloc.dispose();
    super.dispose();
  }
}
