import 'package:hosrem_app/api/conference/conference.dart';
import 'package:hosrem_app/api/conference/conference_fees.dart';
import 'package:hosrem_app/api/conference/conference_member_pagination.dart';
import 'package:hosrem_app/api/conference/conference_pagination.dart';
import 'package:hosrem_app/api/conference/conference_registration.dart';
import 'package:hosrem_app/network/api_provider.dart';

/// Conference service.
class ConferenceService {
  ConferenceService(this.apiProvider) : assert(apiProvider != null);

  final ApiProvider apiProvider;

  /// Get conferences.
  Future<ConferencePagination> getConferences(Map<String, dynamic> queryParams) async {
    final ConferencePagination conferences = await apiProvider.conferenceApi.getAll(queryParams);
    return conferences;
  }

  /// Get conference fees.
  Future<ConferenceFees> getConferenceFees(String conferenceId) async {
    return await apiProvider.conferenceApi.getConferenceFees(conferenceId);
  }

  /// Check if user [userId] registered the conference.
  Future<bool> checkIfUserRegisterConference(String conferenceId, String userId) async {
    return apiProvider.conferenceApi.checkRegistrationStatusOfMember(conferenceId, userId);
  }

  /// Get conference by id.
  Future<Conference> getConferenceById(String id) async {
    return apiProvider.conferenceApi.getConferenceById(id);
  }

  /// Register to take part in the conference.
  Future<ConferenceRegistration> registerConference(String conferenceId,
      ConferenceRegistration conferenceRegistration) async {
    return apiProvider.conferenceApi.registerConferenceById(conferenceId, conferenceRegistration);
  }
}
