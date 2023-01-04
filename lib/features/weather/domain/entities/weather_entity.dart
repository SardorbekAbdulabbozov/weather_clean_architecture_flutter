import 'package:equatable/equatable.dart';

class WeatherEntity extends Equatable {
  final String temperature;
  final String weatherDescription;
  final String maxTemperature;
  final String minTemperature;

  const WeatherEntity({
    required this.temperature,
    required this.weatherDescription,
    required this.maxTemperature,
    required this.minTemperature,
  });

  @override
  List<Object?> get props => [
        temperature,
        weatherDescription,
        maxTemperature,
        minTemperature,
      ];
}
