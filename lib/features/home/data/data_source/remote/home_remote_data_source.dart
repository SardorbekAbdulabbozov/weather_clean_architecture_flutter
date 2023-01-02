import 'package:weather_clean_architecture/features/home/data/models/current_weather_response_model.dart';
import 'package:weather_clean_architecture/features/home/data/models/hourly_forecast_response_model.dart';

abstract class HomeRemoteDataSource {
  Future<CurrentWeatherResponseModel> getCurrentWeather(double lat, double lon);
  Future<HourlyForecastResponseModel> getHourlyForecast(double lat, double lon);
}