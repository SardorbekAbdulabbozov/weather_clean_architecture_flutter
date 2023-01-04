import 'package:dartz/dartz.dart';
import 'package:weather_clean_architecture/core/error/failure.dart';
import 'package:weather_clean_architecture/core/usecase/usecase.dart';
import 'package:weather_clean_architecture/features/weather/domain/entities/weather_entity.dart';
import 'package:weather_clean_architecture/features/weather/domain/repository/weather_repository.dart';

class Weather extends UseCase<WeatherEntity, Params> {
  final WeatherRepository weatherRepository;

  Weather(this.weatherRepository);

  @override
  Future<Either<Failure, WeatherEntity>> call(params) async {
    final response = await weatherRepository.getWeather(params.lat, params.lon);
    print('response: 333 $response');
    return response;
  }
}

class Params {
  final double lat;
  final double lon;

  Params({required this.lat, required this.lon});
}