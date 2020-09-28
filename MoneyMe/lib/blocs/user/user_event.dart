part of 'user_bloc.dart';

abstract class UserEvent {
  final dynamic payload;

  UserEvent({this.payload});
}

class LoadUserInfo extends UserEvent {
  LoadUserInfo(User user) : super(payload: user);
}
