import 'package:equatable/equatable.dart';
import 'package:weather_clean_architecture/features/weather/domain/entities/geocoding_entity.dart';
import 'package:weather_clean_architecture/features/weather/domain/entities/weather_entity.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();
}

class WeatherInitial extends WeatherState {
  @override
  List<Object?> get props => [];
}

class WeatherLoading extends WeatherState {
  @override
  List<Object?> get props => [];
}

class WeatherError extends WeatherState {
  final String message;

  const WeatherError({required this.message});

  @override
  List<Object> get props => [message];
}

class WeatherSuccess extends WeatherState {
  final WeatherEntity? weather;
  final GeocodingEntity? geocoding;

  const WeatherSuccess({
    required this.weather,
    required this.geocoding,
  });

  @override
  List<Object> get props => [];
}
