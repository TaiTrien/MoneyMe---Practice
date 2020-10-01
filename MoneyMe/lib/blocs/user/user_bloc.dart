import 'package:MoneyMe/models/user.dart';
import 'package:bloc/bloc.dart';
part 'user_state.dart';
part 'user_event.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial());
  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is LoadUserInfo) {
      yield LoadingState(state, user: event.payload);
    }
  }
}
