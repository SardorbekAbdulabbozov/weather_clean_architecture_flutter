import 'package:dartz/dartz.dart';
import 'package:weather_clean_architecture/core/error/failure.dart';
import 'package:weather_clean_architecture/features/weather/domain/entities/geocoding_entity.dart';
import 'package:weather_clean_architecture/features/weather/domain/entities/weather_entity.dart';

abstract class WeatherRepository {
  Future<Either<Failure, WeatherEntity>> getWeather(double lat, double lon);
  Future<Either<Failure, List<GeocodingEntity>>> getGeocoding(String city);
}
