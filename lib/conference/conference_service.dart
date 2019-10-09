import 'package:hosrem_app/api/conference/conference_pagination.dart';
import 'package:hosrem_app/api/conference/conference_resource_pagination.dart';
import 'package:hosrem_app/network/api_provider.dart';

/// Conference service.
class ConferenceService {
  ConferenceService(this.apiProvider) : assert(apiProvider != null);

  final ApiProvider apiProvider;

  /// Get conferences.
  Future<ConferencePagination> getConferences(int page, int size) async {
    final ConferencePagination conferences = await apiProvider.conferenceApi.getAll(<String, dynamic>{
      'page': page,
      'size': size
    });
    return conferences;
  }

  /// Get conference resources.
  Future<ConferenceResourcePagination> getConferenceResources(int page, int size) async {
    final ConferenceResourcePagination conferenceResources = await apiProvider.conferenceApi.getAllConferenceResources(<String, dynamic>{
      'page': page,
      'size': size
    });
    return conferenceResources;
  }
}
