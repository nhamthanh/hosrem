import 'package:hosrem_app/api/field/field_pagination.dart';
import 'package:hosrem_app/network/api_provider.dart';

/// Field service.
class FieldService {
  FieldService(this.apiProvider) : assert(apiProvider != null);

  final ApiProvider apiProvider;

  /// Get fields.
  Future<FieldPagination> getAll() async {
    return await apiProvider.fieldApi.getAll();
  }
}
