import 'package:weather_clean_architecture/features/home/data/models/current_weather_response_model.dart';
import 'package:weather_clean_architecture/features/home/data/models/hourly_forecast_response_model.dart';
import 'package:weather_clean_architecture/features/home/data/models/weekly_forecast_response_model.dart';

abstract class HomeLocalDataSource {
  Future<CurrentWeatherResponseModel> getCurrentWeather(double lat, double lon);
  Future<void> setCurrentWeather(double lat, double lon,CurrentWeatherResponseModel data);

  Future<HourlyForecastResponseModel> getHourlyForecast(double lat, double lon);
  Future<void> setHourlyForecast(double lat, double lon,HourlyForecastResponseModel data);

  Future<WeeklyForecastResponseModel> getWeeklyForecast(double lat, double lon);
  Future<void> setWeeklyForecast(double lat, double lon,WeeklyForecastResponseModel data);
}