part of 'jarbloc_bloc.dart';

@immutable
abstract class JarState {
  final List<Jar> jarsList;
  final int remainPercentage;
  final int sliderValue;
  JarState({this.jarsList, this.remainPercentage, this.sliderValue});
}

class JarblocInitial extends JarState {
  JarblocInitial() : super(jarsList: null, remainPercentage: 0, sliderValue: 0);
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

class UpdateSliderValueState extends JarState {
  UpdateSliderValueState(JarState oldState, {int sliderValue})
      : super(
          jarsList: oldState.jarsList,
          remainPercentage: oldState.remainPercentage,
          sliderValue: sliderValue ?? oldState.sliderValue,
        );
}
