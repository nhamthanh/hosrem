import 'package:hosrem_app/api/auth/user.dart';
import 'package:hosrem_app/api/conference/conference_registration.dart';
import 'package:hosrem_app/api/membership/membership.dart';
import 'package:hosrem_app/api/membership/user_membership.dart';
import 'package:hosrem_app/api/payment/payment.dart';
import 'package:hosrem_app/api/payment/payment_type.dart';
import 'package:hosrem_app/api/payment/payment_type_pagination.dart';
import 'package:hosrem_app/auth/auth_service.dart';
import 'package:hosrem_app/conference/conference_service.dart';
import 'package:hosrem_app/network/api_provider.dart';

import 'membership_service.dart';

/// Payment service.
class PaymentService {
  PaymentService(this.apiProvider) :
      assert(apiProvider != null),
      membershipService = MembershipService(apiProvider),
      conferenceService = ConferenceService(apiProvider),
      authService = AuthService(apiProvider);

  final ApiProvider apiProvider;
  final MembershipService membershipService;
  final ConferenceService conferenceService;
  final AuthService authService;

  static const int DEFAULT_PAGE = 0;
  static const int DEFAULT_PAGE_SIZE = 1000;

  /// Get memberships.
  Future<List<PaymentType>> getPaymentTypes() async {
    final PaymentTypePagination paymentTypePagination = await apiProvider.paymentTypeApi.getAll(<String, dynamic>{});
    return paymentTypePagination.items;
  }

  /// Create payment for membership.
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

    return payment;
  }

  /// Create payment for conference.
  Future<Payment> createConferencePayment(String conferenceId, double fee, String letterAddress, String letterType,
      PaymentType paymentType, Map<String, dynamic> detail) async {
    final User user = await authService.currentUser();
    final ConferenceRegistration conferenceRegistration = await conferenceService.registerConference(conferenceId,
      ConferenceRegistration.fromJson(<String, dynamic>{
        'conferenceId': conferenceId,
        'fee': fee,
        'letterAddress': letterAddress,
        'letterType': letterType,
        'paymentStatus': 'Waiting',
        'paymentTypeId': paymentType.id,
        'registerTime': DateTime.now().toIso8601String(),
        'registrationType': 'Other',
        'userId': user.id
      })
    );

    final Payment payment = await apiProvider.paymentApi.createPayment(
      Payment.fromJson(<String, dynamic>{
        'detail': detail,
        'payFor': 'Conference',
        'payRef': conferenceRegistration.registrationId,
        'paymentTypeId': paymentType.id,
        'status': 'Waiting'
      })
    );

    return payment;
  }
}
