// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:dartz/dartz.dart';
import 'package:weather_clean_architecture/core/error/failure.dart';
import 'package:weather_clean_architecture/core/platform/network_info.dart';
import 'package:weather_clean_architecture/features/weather/data/data_source/remote/weather_remote_data_source.dart';
import 'package:weather_clean_architecture/features/weather/data/models/geocoding_response_model.dart';
import 'package:weather_clean_architecture/features/weather/data/models/weather_response_model.dart';
import 'package:weather_clean_architecture/features/weather/domain/entities/geocoding_entity.dart';
import 'package:weather_clean_architecture/features/weather/domain/entities/weather_entity.dart';
import 'package:weather_clean_architecture/features/weather/domain/repository/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource weatherRemoteDataSource;
  final NetworkInfo networkInfo;

  WeatherRepositoryImpl({
    required this.weatherRemoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<GeocodingEntity>>> getGeocoding(String city) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await weatherRemoteDataSource.getGeocoding(city);
        print('response: 000 $response');
        List<GeocodingEntity> result = [];
        response.forEach((element) {
          result.add(element.toEntity());
        });
        return Right(result);
      } catch (e) {
        return Left(
          ServerFailure(
            message: e.toString(),
          ),
        );
      }
    } else {
      return Left(NoInternetFailure());
    }
  }

  @override
  Future<Either<Failure, WeatherEntity>> getWeather(
      double lat, double lon) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await weatherRemoteDataSource.getWeather(lat, lon);
        print('response: 222 $response');
        return Right(response.toEntity());
      } catch (e) {
        return Left(
          ServerFailure(
            message: e.toString(),
          ),
        );
      }
    } else {
      return Left(NoInternetFailure());
    }
  }
}
