part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {
  final dynamic payload;
  AuthEvent({this.payload});
}

class VerifyPhoneNumber extends AuthEvent {
  VerifyPhoneNumber(bool isPhoneNumberValid) : super(payload: isPhoneNumberValid);
}

class VerifyPassword extends AuthEvent {
  VerifyPassword(bool isPasswordValid) : super(payload: isPasswordValid);
}

class VerifyRetypedPassword extends AuthEvent {
  VerifyRetypedPassword(bool isNewPasswordValid) : super(payload: isNewPasswordValid);
}
