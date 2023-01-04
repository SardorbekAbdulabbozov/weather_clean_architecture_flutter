import 'package:dartz/dartz.dart';
import 'package:weather_clean_architecture/core/error/failure.dart';
import 'package:weather_clean_architecture/features/home/domain/enitities/current_weather_entity.dart';
import 'package:weather_clean_architecture/features/home/domain/enitities/hourly_forecast_entity.dart';
import 'package:weather_clean_architecture/features/home/domain/enitities/weekly_forecast_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, CurrentWeatherEntity>> getCurrentWeather(
    double lat,
    double lon,
  );

  Future<Either<Failure, HourlyForecastEntity>> getHourlyForecast(
    double lat,
    double lon,
  );

  Future<Either<Failure, WeeklyForecastEntity>> getWeeklyForecast(
    double lat,
    double lon,
  );
}
