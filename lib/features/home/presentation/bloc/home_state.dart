import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeLoading extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeLoaded extends HomeState {
  final String cityName;
  final String temperature;
  final String weatherDescription;
  final String maxTemperature;
  final String minTemperature;
  final List<String> date;
  final List<double> temp;
  final List<double> windSpeed;

  const HomeLoaded({
    required this.cityName,
    required this.temperature,
    required this.weatherDescription,
    required this.maxTemperature,
    required this.minTemperature,
    required this.date,
    required this.temp,
    required this.windSpeed,
  });

  HomeLoaded copyWith({
    String? cityName,
    String? temperature,
    String? weatherDescription,
    String? maxTemperature,
    String? minTemperature,
    List<String>? date,
    List<double>? temp,
    List<double>? windSpeed,
  }) {
    return HomeLoaded(
      cityName: cityName ?? this.cityName,
      temperature: temperature ?? this.temperature,
      weatherDescription: weatherDescription ?? this.weatherDescription,
      maxTemperature: maxTemperature ?? this.maxTemperature,
      minTemperature: minTemperature ?? this.minTemperature,
      date: date ?? this.date,
      temp: temp ?? this.temp,
      windSpeed: temp ?? this.windSpeed,
    );
  }

  @override
  List<Object?> get props => [
        cityName,
        temperature,
        weatherDescription,
        maxTemperature,
        minTemperature,
        date,
        temp,
        windSpeed,
      ];
}

class HourlyForecastLoaded extends HomeState {
  final List<String> date;
  final List<double> temp;
  final List<double> windSpeed;

  const HourlyForecastLoaded({
    required this.date,
    required this.temp,
    required this.windSpeed,
  });

  @override
  List<Object?> get props => [date, temp, windSpeed];
}

class HomeError extends HomeState {
  final String message;

  const HomeError({required this.message});

  @override
  List<Object> get props => [message];
}

class HomeSuccess extends HomeState {
  @override
  List<Object> get props => [];
}
