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
}
