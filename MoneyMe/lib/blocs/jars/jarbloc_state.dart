part of 'jarbloc_bloc.dart';

@immutable
abstract class JarState {
  final List<Jar> jarsList;
  final int remainPercentage;

  JarState({this.jarsList, this.remainPercentage});

  int get remainMoney;
}

class JarblocInitial extends JarState {
  JarblocInitial()
      : super(
          jarsList: null,
          remainPercentage: 0,
        );

  int get remainMoney => jarsList.fold(0, (total, jar) => total + jar.price) ?? 0;
}

class UpdateJarsState extends JarState {
  UpdateJarsState(JarState oldState, {List<Jar> jarsList}) : super(jarsList: jarsList ?? oldState.jarsList);

  int get remainMoney => jarsList.fold(0, (total, jar) => total + jar.price);
}

class UpdatePercentageState extends JarState {
  UpdatePercentageState(JarState oldState, {int remainPercentage})
      : super(
          jarsList: oldState.jarsList,
          remainPercentage: remainPercentage ?? oldState.remainPercentage,
        );

  int get remainMoney => jarsList.fold(0, (total, jar) => total + jar.price);
}
