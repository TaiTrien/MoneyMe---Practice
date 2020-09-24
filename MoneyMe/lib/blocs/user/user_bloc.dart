import 'package:MoneyMe/screens/dashboard/home/home_controller.dart';
import 'package:bloc/bloc.dart';
part 'user_state.dart';
part 'user_event.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial());
  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is GetUserName) {
      yield UpdateState(state, userName: event.payload);
    }
  }
}
