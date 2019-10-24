import 'package:hosrem_app/api/membership/membership_pagination.dart';
import 'package:hosrem_app/api/membership/user_membership.dart';
import 'package:hosrem_app/network/api_provider.dart';

/// Membership service.
class MembershipService {
  MembershipService(this.apiProvider) : assert(apiProvider != null);

  final ApiProvider apiProvider;

  static const int DEFAULT_PAGE = 0;
  static const int DEFAULT_PAGE_SIZE = 1000;

  /// Get memberships.
  Future<MembershipPagination> getMemberships() async {
    final MembershipPagination membershipPagination = await apiProvider.membershipApi.getAll(<String, dynamic>{
      'page': DEFAULT_PAGE,
      'size': DEFAULT_PAGE_SIZE
    });
    return membershipPagination;
  }

  /// Get user membership by [userId].
  Future<UserMembership> getMembershipStatusOfUser(String userId) async {
    final UserMembership userMembership = await apiProvider.userMembershipApi.getMembershipStatusByUserId(userId);
    return userMembership;
  }
}
