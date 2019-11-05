import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hosrem_app/api/auth/degree.dart';
import 'package:hosrem_app/api/auth/field.dart';
import 'package:hosrem_app/api/auth/user.dart';
import 'package:hosrem_app/api/degree/degree_pagination.dart';
import 'package:hosrem_app/api/field/field_pagination.dart';
import 'package:hosrem_app/auth/auth_service.dart';
import 'package:hosrem_app/common/error_handler.dart';
import 'package:hosrem_app/profile/bloc/profile_update_event.dart';
import 'package:hosrem_app/profile/bloc/profile_update_state.dart';
import 'package:hosrem_app/profile/degree_service.dart';
import 'package:hosrem_app/profile/field_service.dart';
import 'package:meta/meta.dart';

/// Profile update bloc load and update user profile.
class ProfileUpdateBloc extends Bloc<ProfileUpdateEvent, ProfileUpdateState> {
  ProfileUpdateBloc({
    @required this.authService,
    this.degreeService,
    this.fieldService
  })  : assert(authService != null);

  final AuthService authService;
  final DegreeService degreeService;
  final FieldService fieldService;

  @override
  ProfileUpdateState get initialState => ProfileInitial();

  @override
  Stream<ProfileUpdateState> mapEventToState(ProfileUpdateEvent event) async* {
    if (event is LoadProfileEvent) {
      yield ProfileLoading();

      try {
        final User user = await authService.currentUser();
        final DegreePagination degreePagination = await degreeService.getAll();
        final List<Degree> degrees = degreePagination.items;
        final FieldPagination fieldPagination = await fieldService.getAll();
        final List<Field> fields = fieldPagination.items;
        yield ProfileDataUpdate(user: user, degrees: degrees, fields: fields);
      } catch (error) {
        yield ProfileFailure(error: ErrorHandler.extractErrorMessage(error));
      }
    }

    if (event is SaveProfileEvent) {
      yield ProfileLoading();

      try {
        await authService.updateProfile(event.user);
        await authService.persistCurrentUser(event.user);
        yield UpdateProfileSuccess();
      } catch (error) {
        yield ProfileFailure(error: ErrorHandler.extractErrorMessage(error));
      }
    }

    if (event is ChangeProfileEvent) {
      yield ProfileDataUpdate(user: event.user);
    }
  }
}
