// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:weather_clean_architecture/constants/constants.dart';
import 'package:weather_clean_architecture/core/error/exceptions.dart';
import 'package:weather_clean_architecture/features/home/data/data_source/local/home_local_data_source.dart';
import 'package:weather_clean_architecture/features/home/data/models/current_weather_response_model.dart';
import 'package:weather_clean_architecture/features/home/data/models/hourly_forecast_response_model.dart';

const errorMessage = "No such data in Database";
const misMatchingId = "Ids do not match";

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  final Box<dynamic> box;

  HomeLocalDataSourceImpl(this.box);

  @override
  Future<CurrentWeatherResponseModel> getCurrentWeather(
    double lat,
    double lon,
  ) async {
    final data = await box.get(
      '${DatabaseKeys.CURRENT_WEATHER}${lat}_$lon',
      defaultValue: null,
    );
    if (data != null) {
      return CurrentWeatherResponseModel.fromJson(jsonDecode(data));
    } else {
      throw CacheException(message: errorMessage);
    }
  }

  @override
  Future<HourlyForecastResponseModel> getHourlyForecast(
      double lat, double lon) async {
    final data = await box.get(
      '${DatabaseKeys.HOURLY}${lat}_$lon',
      defaultValue: null,
    );
    if (data != null) {
      return HourlyForecastResponseModel.fromJson(jsonDecode(data));
    } else {
      throw CacheException(message: errorMessage);
    }
  }

  @override
  Future<void> setCurrentWeather(
      double lat, double lon, CurrentWeatherResponseModel data) async {
    final currentWeather = jsonEncode(data.toJson());
    await box.put('${DatabaseKeys.CURRENT_WEATHER}${lat}_$lon', currentWeather);
  }

  @override
  Future<void> setHourlyForecast(
      double lat, double lon, HourlyForecastResponseModel data) async {
    final hourlyWeather = jsonEncode(data.toJson());
    await box.put('${DatabaseKeys.HOURLY}${lat}_$lon', hourlyWeather);
  }
}
