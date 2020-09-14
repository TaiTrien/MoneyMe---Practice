part of 'auth_bloc.dart';

abstract class AuthState {
  final User user;
  AuthState({this.user});
}
