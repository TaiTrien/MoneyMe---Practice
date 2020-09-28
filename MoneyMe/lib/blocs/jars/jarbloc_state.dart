part of 'jarbloc_bloc.dart';

@immutable
abstract class JarState {
  final List<Jar> jarsList;
  JarState({this.jarsList});
}

class JarblocInitial extends JarState {
  JarblocInitial() : super(jarsList: null);
}

class LoadingState extends JarState {
  LoadingState(JarState oldState, {List<Jar> jarsList}) : super(jarsList: jarsList ?? oldState.jarsList);
}
