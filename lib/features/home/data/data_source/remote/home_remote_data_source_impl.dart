import 'package:dio/dio.dart';
import 'package:weather_clean_architecture/constants/constants.dart';
import 'package:weather_clean_architecture/core/error/exceptions.dart';
import 'package:weather_clean_architecture/features/home/data/data_source/remote/home_remote_data_source.dart';
import 'package:weather_clean_architecture/features/home/data/models/current_weather_response_model.dart';
import 'package:weather_clean_architecture/features/home/data/models/hourly_forecast_response_model.dart';
import 'package:weather_clean_architecture/features/home/data/models/weekly_forecast_response_model.dart';

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final Dio dio;

  HomeRemoteDataSourceImpl(this.dio);

  var requestOptions = Options(
    contentType: 'application/json',
    sendTimeout: 30,
  );

  @override
  Future<CurrentWeatherResponseModel> getCurrentWeather(
    double lat,
    double lon,
  ) async {
    try {
      final response = await dio.get(
        Constants.BASE_URL_1 + Urls.CURRENT_WEATHER,
        queryParameters: {
          'lat': lat,
          'lon': lon,
          'appid': Constants.APP_ID,
          'units': 'metric',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return CurrentWeatherResponseModel.fromJson(response.data);
      } else {
        throw ServerException.fromJson(response.data);
      }
    } on DioError catch (e) {
      throw ServerException.fromJson(e.response?.data);
    } on FormatException {
      throw ServerException(message: Validations.SOMETHING_WENT_WRONG);
    }
  }

  @override
  Future<HourlyForecastResponseModel> getHourlyForecast(
    double lat,
    double lon,
  ) async {
    try {
      final response = await dio.get(
        Constants.BASE_URL_2 + Urls.HOURLY_FORECAST,
        queryParameters: {
          'latitude': lat,
          'longitude': lon,
          'hourly': ['temperature_2m', 'windspeed_10m'],
          'current_weather': false,
          'timezone': 'auto',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return HourlyForecastResponseModel.fromJson(response.data);
      } else {
        throw ServerException.fromJson(response.data);
      }
    } on DioError catch (e) {
      throw ServerException.fromJson(e.response?.data);
    } on FormatException {
      throw ServerException(message: Validations.SOMETHING_WENT_WRONG);
    }
  }

  @override
  Future<WeeklyForecastResponseModel> getWeeklyForecast(
    double lat,
    double lon,
  ) async {
    try {
      final response = await dio.get(
        Constants.BASE_URL_2 + Urls.HOURLY_FORECAST,
        queryParameters: {
          'latitude': lat,
          'longitude': lon,
          'daily': [
            'temperature_2m_max',
            'temperature_2m_min',
            'rain_sum',
            'windspeed_10m_max',
          ],
          'current_weather': false,
          'timezone': 'auto',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return WeeklyForecastResponseModel.fromJson(response.data);
      } else {
        throw ServerException.fromJson(response.data);
      }
    } on DioError catch (e) {
      throw ServerException.fromJson(e.response?.data);
    } on FormatException {
      throw ServerException(message: Validations.SOMETHING_WENT_WRONG);
    }
  }
}
