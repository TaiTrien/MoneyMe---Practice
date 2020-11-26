part of 'statistic_bloc.dart';

@immutable
abstract class StatisticEvent {
  final DateTime startDate;
  final DateTime endDate;
  StatisticEvent({this.startDate, this.endDate});
}

class LoadStatistic extends StatisticEvent {
  LoadStatistic(DateTime startDate, DateTime endDate)
      : super(
          startDate: startDate,
          endDate: endDate,
        );
}
