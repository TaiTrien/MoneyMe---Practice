part of 'auth_bloc.dart';

@immutable
abstract class AuthState {
  final bool isPhoneNumberValid;
  final bool isPasswordValid;
  final bool isNewPasswordValid;

  AuthState({
    this.isPhoneNumberValid,
    this.isPasswordValid,
    this.isNewPasswordValid,
  });
}

class AuthInitialState extends AuthState {
  AuthInitialState() : super(isPhoneNumberValid: true, isPasswordValid: true, isNewPasswordValid: true);
}

class AuthVerifyingState extends AuthState {
  AuthVerifyingState(
    AuthState oldState, {
    bool isPhoneNumberValid,
    bool isPasswordValid,
    bool isNewPasswordValid,
  }) : super(
          isPhoneNumberValid: isPhoneNumberValid ?? oldState.isPhoneNumberValid,
          isPasswordValid: isPasswordValid ?? oldState.isPasswordValid,
          isNewPasswordValid: isNewPasswordValid ?? oldState.isNewPasswordValid,
        );
}
