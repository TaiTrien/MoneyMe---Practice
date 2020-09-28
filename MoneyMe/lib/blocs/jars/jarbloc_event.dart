part of 'jarbloc_bloc.dart';

@immutable
abstract class JarEvent {
  final dynamic payload;

  JarEvent({this.payload});
}

class LoadJarsData extends JarEvent {
  LoadJarsData(List<Jar> jarsList) : super(payload: jarsList);
}
