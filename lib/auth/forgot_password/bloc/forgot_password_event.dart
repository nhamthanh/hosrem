import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// Forgot Password event.
@immutable
abstract class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent([List<dynamic> props = const <dynamic>[]]) : super(props);
}

/// VerifyEmail event.
class VerifyEmailEvent extends ForgotPasswordEvent {
  VerifyEmailEvent(this.email) : super(<dynamic>[email]);

  final String email;
  @override
  String toString() =>
      'VerifyEmailEvent {email: $email}';
}

/// VerifyCode event.
class VerifyCodeEvent extends ForgotPasswordEvent {
  VerifyCodeEvent(this.code) : super(<dynamic>[code]);
  final String code;
  @override
  String toString() =>
      'VerifyCodeEvent {code: $code}';
}

/// ChangePassword event.
class ChangePasswordEvent extends ForgotPasswordEvent {
  ChangePasswordEvent(this.code, this.password) : super(<dynamic>[code, password]);
  final String code;
  final String password;
  @override
  String toString() =>
      'ChangePasswordEvent {code: $code}';
}
