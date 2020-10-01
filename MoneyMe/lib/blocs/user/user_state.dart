part of 'user_bloc.dart';

abstract class UserState {
  final User user;
  UserState({this.user});
}

class UserInitial extends UserState {
  UserInitial() : super(user: User('default user', null, null));
}

class LoadingState extends UserState {
  LoadingState(UserState oldState, {User user}) : super(user: user ?? oldState.user);
}
