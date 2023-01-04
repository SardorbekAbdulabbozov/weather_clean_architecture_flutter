import 'package:equatable/equatable.dart';

class WeeklyForecastEntity extends Equatable {
  final List<String> dates;
  final List<double> temps;
  final List<double> windSpeeds;

  const WeeklyForecastEntity({
    required this.dates,
    required this.temps,
    required this.windSpeeds,
  });

  @override
  List<Object?> get props => [dates, temps, windSpeeds];
}
