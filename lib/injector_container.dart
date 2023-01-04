import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:weather_clean_architecture/core/platform/network_info.dart';
import 'package:weather_clean_architecture/features/home/data/data_source/local/home_local_data_source.dart';
import 'package:weather_clean_architecture/features/home/data/data_source/local/home_local_data_source_impl.dart';
import 'package:weather_clean_architecture/features/home/data/data_source/remote/home_remote_data_source.dart';
import 'package:weather_clean_architecture/features/home/data/data_source/remote/home_remote_data_source_impl.dart';
import 'package:weather_clean_architecture/features/home/data/repository/home_repository_impl.dart';
import 'package:weather_clean_architecture/features/home/domain/repository/home_repository.dart';
import 'package:weather_clean_architecture/features/home/domain/usecases/current_weather.dart';
import 'package:weather_clean_architecture/features/home/domain/usecases/hourly_forecast.dart';
import 'package:weather_clean_architecture/features/home/domain/usecases/weekly_forecast.dart';
import 'package:weather_clean_architecture/features/home/presentation/bloc/home_bloc.dart';
import 'package:weather_clean_architecture/features/weather/data/data_source/remote/weather_remote_data_source.dart';
import 'package:weather_clean_architecture/features/weather/data/data_source/remote/weather_remote_data_source_impl.dart';
import 'package:weather_clean_architecture/features/weather/data/repository/weather_repository_impl.dart';
import 'package:weather_clean_architecture/features/weather/domain/repository/weather_repository.dart';
import 'package:weather_clean_architecture/features/weather/domain/usecases/geocoding.dart';
import 'package:weather_clean_architecture/features/weather/domain/usecases/weather.dart';
import 'package:weather_clean_architecture/features/weather/presentation/bloc/weather_bloc.dart';

final sl = GetIt.instance;
late Box<dynamic> _box;

Future<void> init() async {
  // external
  await initHive();
  sl.registerLazySingleton(
    () => Dio()
      ..interceptors.add(
        LogInterceptor(
          request: true,
          responseBody: true,
          error: true,
          requestBody: true,
        ),
      ),
  );
  sl.registerLazySingleton(() => InternetConnectionCheckerPlus());

  // core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // features
  homeFeature();
  weatherFeature();
}

void homeFeature() {
  // bloc
  sl.registerFactory(
    () => HomeBloc(
      currentWeather: sl(),
      hourlyForecast: sl(),
      weeklyForecast: sl(),
    ),
  );

  // usecases
  sl.registerLazySingleton<CurrentWeather>(() => CurrentWeather(sl()));
  sl.registerLazySingleton<HourlyForecast>(() => HourlyForecast(sl()));
  sl.registerLazySingleton<WeeklyForecast>(() => WeeklyForecast(sl()));

  // repository
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(
      homeRemoteDataSource: sl(),
      homeLocalDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // data sources
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<HomeLocalDataSource>(
    () => HomeLocalDataSourceImpl(_box),
  );
}

void weatherFeature() {
  // bloc
  sl.registerFactory(
    () => WeatherBloc(
      weather: sl(),
      geocoding: sl(),
    ),
  );

  // usecases
  sl.registerLazySingleton<Weather>(() => Weather(sl()));
  sl.registerLazySingleton<Geocoding>(() => Geocoding(sl()));

  // repository
  sl.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(
      weatherRemoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // data sources
  sl.registerLazySingleton<WeatherRemoteDataSource>(
    () => WeatherRemoteDataSourceImpl(sl()),
  );
}

Future<void> initHive() async {
  const boxName = 'weather_clean_architecture_box';
  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  _box = await Hive.openBox<dynamic>(boxName);
}
