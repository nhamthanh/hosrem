import 'package:hosrem_app/api/auth/user.dart';
import 'package:hosrem_app/api/membership/membership.dart';
import 'package:hosrem_app/api/membership/user_membership.dart';
import 'package:hosrem_app/api/payment/payment.dart';
import 'package:hosrem_app/api/payment/payment_type.dart';
import 'package:hosrem_app/api/payment/payment_type_pagination.dart';
import 'package:hosrem_app/auth/auth_service.dart';
import 'package:hosrem_app/network/api_provider.dart';

import 'membership_service.dart';

/// Payment service.
class PaymentService {
  PaymentService(this.apiProvider) :
      assert(apiProvider != null),
      membershipService = MembershipService(apiProvider),
      authService = AuthService(apiProvider);

  final ApiProvider apiProvider;
  final MembershipService membershipService;
  final AuthService authService;

  static const int DEFAULT_PAGE = 0;
  static const int DEFAULT_PAGE_SIZE = 1000;

  /// Get memberships.
  Future<List<PaymentType>> getPaymentTypes() async {
    final PaymentTypePagination paymentTypePagination = await apiProvider.paymentTypeApi.getAll(<String, dynamic>{});
    return paymentTypePagination.items;
  }

  /// Get memberships.
  Future<Payment> createPayment(Membership membership, PaymentType paymentType, Map<String, dynamic> detail) async {
    final User user = await authService.currentUser();
    final UserMembership userMembership = await membershipService.createUserMembership(
      UserMembership.fromJson(<String, dynamic>{
        'membership': membership.toJson(),
        'registerTime': DateTime.now().toIso8601String(),
        'expiredTime': DateTime.now().toIso8601String(),
        'paymentStatus': 'Waiting',
        'paymentType': paymentType.toJson(),
        'userId': user.id
      })
    );

    final Payment payment = await apiProvider.paymentApi.createPayment(
      Payment.fromJson(<String, dynamic>{
        'detail': detail,
        'payFor': 'Membership',
        'payRef': userMembership.id,
        'paymentTypeId': paymentType.id,
        'status': 'Waiting'
      })
    );

    return apiProvider.paymentApi.createPayment(payment);
  }
}
