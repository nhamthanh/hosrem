import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hosrem_app/api/auth/user.dart';
import 'package:hosrem_app/api/conference/conference_registration.dart';
import 'package:hosrem_app/api/conference/update_registration_status.dart';
import 'package:hosrem_app/auth/auth_service.dart';
import 'package:hosrem_app/common/error_handler.dart';
import 'package:logging/logging.dart';

import '../conference_service.dart';
import 'login_conference_event.dart';
import 'login_conference_state.dart';

/// Login conference bloc.
class LoginConferenceBloc extends Bloc<LoginConferenceEvent, LoginConferenceState> {
  LoginConferenceBloc(this.authService, this.conferenceService);

  final ConferenceService conferenceService;
  final AuthService authService;
  final Logger _logger = Logger('LoginConferenceBloc');

  final Map<String, bool> _fields = <String, bool>{};

  @override
  LoginConferenceState get initialState {
    _fields['fullName'] = true;
    _fields['registrationCode'] = true;
    return LoginConferenceLoading();
  }

  @override
  Stream<LoginConferenceState> mapEventToState(LoginConferenceEvent event) async* {
    if (event is LoginConferencePressedEvent) {
      try {
        yield LoginConferenceLoading();

        if (event.fullName.isEmpty || event.registrationCode.isEmpty) {
          _fields['fullName'] = event.fullName.isNotEmpty;
          _fields['registrationCode'] = event.registrationCode.isNotEmpty;
          yield LoginConferenceValidation(fields: _fields);
          return;
        }

        final User currentUser = await authService.currentUser();
        ConferenceRegistration conferenceRegistration;
        if (currentUser != null) {
          final UpdateRegistrationStatus updateRegistrationStatus = UpdateRegistrationStatus(
            event.conference.id,
            event.fullName,
            event.registrationCode,
            'Mobile',
            'Confirmed',
            null,
            currentUser.id
          );
          conferenceRegistration = await conferenceService.updateConferenceRegistrationStatus(updateRegistrationStatus);
        } else {
          conferenceRegistration = await conferenceService.getRegistrationInfoFromRegCode(event.conference.id, event.registrationCode);
        }

        if (conferenceRegistration?.user?.fullName != event.fullName) {
          yield LoginConferenceFailure(error: 'Tên hoặc mã hội nghị của bạn không đúng. Vui lòng thử lại.');
          return;
        }

        if (currentUser == null) {
          await authService.persistConferenceAuth(event.conference.id, event.fullName, event.registrationCode);
        }
        yield LoginConferenceSuccess();
      } catch (error) {
        _logger.fine(error);
        yield LoginConferenceFailure(error: ErrorHandler.extractErrorMessage(error));
      }
    }


    if (event is ValidateFormFieldEvent) {
      try {
        _fields[event.name] = event.value.isNotEmpty;
        yield LoginConferenceValidation(fields: _fields);
      } catch (error) {
        _logger.fine(error);
        yield LoginConferenceFailure(error: ErrorHandler.extractErrorMessage(error));
      }
    }
  }
}
