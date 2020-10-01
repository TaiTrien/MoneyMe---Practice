import 'dart:async';

import 'package:MoneyMe/models/jar.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'jarbloc_event.dart';
part 'jarbloc_state.dart';

class JarBloc extends Bloc<JarEvent, JarState> {
  JarBloc() : super(JarblocInitial());

  @override
  Stream<JarState> mapEventToState(JarEvent event) async* {
    if (event is UpdateJarsData) {
      yield UpdateJarsState(state, jarsList: event.payload);
    } else if (event is UpdateRemainPercentage) {
      yield UpdatePercentageState(state, remainPercentage: event.payload);
    }
  }
}
