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
    if (event is LoadJarsData) {
      yield LoadingState(state, jarsList: event.payload);
    }
  }
}
