part of 'user_bloc.dart';

abstract class UserState {
  final String userName;
  UserState({this.userName});
}

class UserInitial extends UserState {
  UserInitial() : super(userName: 'User1');
}

class UpdateState extends UserState {
  UpdateState(UserState oldState, {String userName})
      : super(
          userName: userName ?? oldState.userName,
        );
}
