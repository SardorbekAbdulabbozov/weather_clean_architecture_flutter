import 'package:weather_clean_architecture/features/weather/data/models/geocoding_response_model.dart';
import 'package:weather_clean_architecture/features/weather/data/models/weather_response_model.dart';

abstract class WeatherRemoteDataSource{
  Future<WeatherResponseModel> getWeather(double lat, double lon);
  Future<List<GeocodingResponseModel>> getGeocoding(String city);
}