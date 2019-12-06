import 'package:hosrem_app/api/conference/public_registration_pagination.dart';
import 'package:hosrem_app/network/api_provider.dart';

/// SearchRegisteredUsersService service.
class SearchRegisteredUsersService {
  SearchRegisteredUsersService(this.apiProvider) : assert(apiProvider != null);

  final ApiProvider apiProvider;

  /// Get search registered users.
  Future<PublicRegistrationPagination> getSearchRegisteredUsers(String conferenceId, Map<String, dynamic> queryParams) async {
    final PublicRegistrationPagination publicRegistrationPagination = await apiProvider.conferenceApi.getParticipates(conferenceId, queryParams);
    return publicRegistrationPagination;
  }

}
