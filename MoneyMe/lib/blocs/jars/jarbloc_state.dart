part of 'jarbloc_bloc.dart';

@immutable
abstract class JarState {
  final List<Jar> jarsList;
  final int remainPercentage;
  JarState({this.jarsList, this.remainPercentage});
}

class JarblocInitial extends JarState {
  JarblocInitial() : super(jarsList: null, remainPercentage: 100);
}

class UpdateJarsState extends JarState {
  UpdateJarsState(JarState oldState, {List<Jar> jarsList}) : super(jarsList: jarsList ?? oldState.jarsList);
}

class UpdatePercentageState extends JarState {
  UpdatePercentageState(JarState oldState, {int remainPercentage})
      : super(
          jarsList: oldState.jarsList,
          remainPercentage: remainPercentage ?? oldState.remainPercentage,
        );
}
