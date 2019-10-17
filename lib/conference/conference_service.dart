import 'package:hosrem_app/api/conference/conference_fees.dart';
import 'package:hosrem_app/api/conference/conference_member_pagination.dart';
import 'package:hosrem_app/api/conference/conference_pagination.dart';
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
    final ConferenceMemberPagination conferenceMemberPagination = await apiProvider.conferenceApi.getConferenceMembers(
      conferenceId, <String, String>{ 'user': userId });

    return conferenceMemberPagination.totalItems > 0;
  }
}
