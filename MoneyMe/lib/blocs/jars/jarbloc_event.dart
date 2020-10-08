part of 'jarbloc_bloc.dart';

@immutable
abstract class JarEvent {
  final dynamic payload;

  JarEvent({this.payload});
}

class UpdateJarsData extends JarEvent {
  UpdateJarsData(List<Jar> jarsList) : super(payload: jarsList);
}

class UpdateRemainPercentage extends JarEvent {
  UpdateRemainPercentage(int remainPercentage) : super(payload: remainPercentage);
}

class UpdateSliderValue extends JarEvent {
  UpdateSliderValue(int sliderValue) : super(payload: sliderValue);
}
