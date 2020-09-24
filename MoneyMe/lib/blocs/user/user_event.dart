part of 'user_bloc.dart';

abstract class UserEvent {
  final dynamic payload;

  UserEvent({this.payload});
}

class GetUserName extends UserEvent {
  GetUserName(String userName) : super(payload: userName);
}
