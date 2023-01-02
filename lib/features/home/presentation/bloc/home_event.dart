import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class CurrentWeatherRefresh extends HomeEvent {
  final double lat;
  final double lon;

  const CurrentWeatherRefresh({
    required this.lat,
    required this.lon,
  });

  @override
  List<Object?> get props => [];
}

class WeeklyWeatherPressed extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class HourlyForecastPressed extends HomeEvent {
  final double lat;
  final double lon;

  const HourlyForecastPressed({
    required this.lat,
    required this.lon,
  });

  @override
  List<Object?> get props => [];
}
