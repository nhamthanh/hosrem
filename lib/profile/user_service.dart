import 'package:hosrem_app/api/auth/user.dart';
import 'package:hosrem_app/api/conference/user_conference_pagination.dart';
import 'package:hosrem_app/auth/auth_service.dart';
import 'package:hosrem_app/network/api_provider.dart';

/// User service.
class UserService {
  UserService(this.apiProvider, this.authService) : assert(apiProvider != null), assert(authService != null);

  final ApiProvider apiProvider;
  final AuthService authService;

  static const String ATTENDANCE = 'attendances';
  static const String GET_LAST = ATTENDANCE + '/last';
  static const String CHECKIN = ATTENDANCE + '/checkin';
  static const String CHECKOUT = ATTENDANCE + '/checkout';

  /// Update user profile via [user].
  Future<bool> updateProfile(User user) async {
    await Future<String>.delayed(Duration(seconds: 1));
    return true;
  }

  /// Get registered conferences which current user registers.
  Future<UserConferencePagination> getRegisteredConferences(Map<String, dynamic> queryParams) async {
    final User user = await authService.currentUser();
    return apiProvider.userApi.getRegisteredConferences(user.id, queryParams);
  }
}
