import 'package:hosrem_app/api/auth/user.dart';
import 'package:hosrem_app/network/api_provider.dart';

/// User service.
class UserService {
  UserService(this.apiProvider) : assert(apiProvider != null);

  final ApiProvider apiProvider;

  static const String ATTENDANCE = 'attendances';
  static const String GET_LAST = ATTENDANCE + '/last';
  static const String CHECKIN = ATTENDANCE + '/checkin';
  static const String CHECKOUT = ATTENDANCE + '/checkout';

  /// Update user profile via [user].
  Future<bool> updateProfile(User user) async {
    await Future<String>.delayed(Duration(seconds: 1));
    return true;
  }
}
