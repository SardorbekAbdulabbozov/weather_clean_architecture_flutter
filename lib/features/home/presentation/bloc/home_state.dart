import 'package:equatable/equatable.dart';
import 'package:weather_clean_architecture/features/home/domain/enitities/current_weather_entity.dart';
import 'package:weather_clean_architecture/features/home/domain/enitities/hourly_forecast_entity.dart';
import 'package:weather_clean_architecture/features/home/domain/enitities/weekly_forecast_entity.dart';

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

class HomeCurrentWeatherError extends HomeState {
  final String message;

  const HomeCurrentWeatherError({required this.message});

  @override
  List<Object> get props => [message];
}

class HomeHourlyForecastError extends HomeState {
  final String message;

  const HomeHourlyForecastError({required this.message});

  @override
  List<Object> get props => [message];
}

class HomeWeeklyForecastError extends HomeState {
  final String message;

  const HomeWeeklyForecastError({required this.message});

  @override
  List<Object> get props => [message];
}

class HomeSuccess extends HomeState {
  final CurrentWeatherEntity? currentWeather;
  final HourlyForecastEntity? hourlyForecast;
  final WeeklyForecastEntity? weeklyForecast;

  const HomeSuccess({
    required this.currentWeather,
    required this.hourlyForecast,
    required this.weeklyForecast,
  });

  @override
  List<Object> get props => [];
}
