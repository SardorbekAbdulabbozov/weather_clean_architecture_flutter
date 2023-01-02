import 'package:dartz/dartz.dart';
import 'package:weather_clean_architecture/core/error/failure.dart';
import 'package:weather_clean_architecture/core/platform/network_info.dart';
import 'package:weather_clean_architecture/features/home/data/data_source/local/home_local_data_source.dart';
import 'package:weather_clean_architecture/features/home/data/data_source/remote/home_remote_data_source.dart';
import 'package:weather_clean_architecture/features/home/data/models/current_weather_response_model.dart';
import 'package:weather_clean_architecture/features/home/data/models/hourly_forecast_response_model.dart';
import 'package:weather_clean_architecture/features/home/domain/enitities/current_weather_entity.dart';
import 'package:weather_clean_architecture/features/home/domain/enitities/hourly_forecast_entity.dart';
import 'package:weather_clean_architecture/features/home/domain/repository/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource homeRemoteDataSource;
  final HomeLocalDataSource homeLocalDataSource;
  final NetworkInfo networkInfo;

  HomeRepositoryImpl({
    required this.homeRemoteDataSource,
    required this.homeLocalDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, CurrentWeatherEntity>> getCurrentWeather(
      double lat, double lon,
      {bool isCached = false}) async {
    if (await networkInfo.isConnected) {
      if (isCached) {
        try {
          final response =
              await homeLocalDataSource.getCurrentWeather(lat, lon);
          return Right(response.toEntity());
        } catch (e) {
          return Left(
            ServerFailure(
              message: e.toString(),
            ),
          );
        }
      } else {
        try {
          final response =
              await homeRemoteDataSource.getCurrentWeather(lat, lon);
          // await homeLocalDataSource.setCurrentWeather(lat, lon, response);
          return Right(response.toEntity());
        } catch (e) {
          return Left(
            ServerFailure(
              message: e.toString(),
            ),
          );
        }
      }
    } else {
      return Left(
        NoInternetFailure(),
      );
    }
  }

  @override
  Future<Either<Failure, HourlyForecastEntity>> getHourlyForecast(
      double lat, double lon) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await homeRemoteDataSource.getHourlyForecast(lat, lon);
        return Right(response.toEntity());
      } catch (e) {
        return Left(
          ServerFailure(
            message: e.toString(),
          ),
        );
      }
    } else {
      return Left(
        NoInternetFailure(),
      );
    }
  }
}
