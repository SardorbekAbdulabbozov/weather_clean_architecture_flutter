import 'package:equatable/equatable.dart';

class HourlyForecastEntity extends Equatable {
  final List<String> dates;
  final List<double> temps;
  final List<double> windSpeeds;

  const HourlyForecastEntity({
    required this.dates,
    required this.temps,
    required this.windSpeeds,
  });

  @override
  List<Object?> get props => [dates, temps, windSpeeds];
}
