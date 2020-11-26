part of 'statistic_bloc.dart';

@immutable
abstract class StatisticState {
  final DateTime startDate;
  final DateTime endDate;

  StatisticState({this.startDate, this.endDate});
}

class StatisticInitial extends StatisticState {
  StatisticInitial()
      : super(
          startDate: DateTime(DateTime.now().year, DateTime.now().month, 1),
          endDate: DateTime(DateTime.now().year, DateTime.now().month + 1, 0),
        );
}

class UpdateState extends StatisticState {
  UpdateState(
    StatisticState oldState, {
    DateTime startDate,
    DateTime endDate,
  }) : super(
          startDate: startDate ?? oldState.startDate,
          endDate: endDate ?? oldState.endDate,
        );
}
