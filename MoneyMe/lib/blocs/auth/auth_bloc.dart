import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitialState());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is VerifyPhoneNumber) {
      yield AuthVerifyingState(state, isPhoneNumberValid: event.payload);
    } else if (event is VerifyPassword) {
      yield AuthVerifyingState(state, isPasswordValid: event.payload);
    } else if (event is VerifyRetypedPassword) {
      yield AuthVerifyingState(state, isNewPasswordValid: event.payload);
    }
  }
}
