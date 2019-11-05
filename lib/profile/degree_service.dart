import 'package:hosrem_app/api/degree/degree_pagination.dart';
import 'package:hosrem_app/network/api_provider.dart';

/// degree service.
class DegreeService {
  DegreeService(this.apiProvider) : assert(apiProvider != null);

  final ApiProvider apiProvider;

  /// Get fields.
  Future<DegreePagination> getAll() async {
    return await apiProvider.degreeApi.getAll();
  }

}
