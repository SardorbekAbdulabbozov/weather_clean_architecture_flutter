import 'package:equatable/equatable.dart';

class CurrentWeatherEntity extends Equatable {
  final String cityName;
  final String temperature;
  final String weatherDescription;
  final String maxTemperature;
  final String minTemperature;

  const CurrentWeatherEntity({
    required this.cityName,
    required this.temperature,
    required this.weatherDescription,
    required this.maxTemperature,
    required this.minTemperature,
  });

  @override
  List<Object?> get props => [
        cityName,
        temperature,
        weatherDescription,
        maxTemperature,
        minTemperature,
      ];
}
