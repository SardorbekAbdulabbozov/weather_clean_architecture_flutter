import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class GetWeatherByLocation extends WeatherEvent {
  final String city;

  const GetWeatherByLocation({
    required this.city,
  });

  @override
  List<Object?> get props => [city];
}
