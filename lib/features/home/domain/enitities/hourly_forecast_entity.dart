import 'package:equatable/equatable.dart';

class HourlyForecastEntity extends Equatable {
  final List<String> date;
  final List<double> temps;
  final List<double> windSpeeds;

  const HourlyForecastEntity({
    required this.date,
    required this.temps,
    required this.windSpeeds,
  });

  @override
  List<Object?> get props => [date, temps, windSpeeds];
}
