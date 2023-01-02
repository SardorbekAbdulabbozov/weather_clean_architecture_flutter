import 'package:dartz/dartz.dart';
import 'package:weather_clean_architecture/core/error/failure.dart';
import 'package:weather_clean_architecture/core/usecase/usecase.dart';
import 'package:weather_clean_architecture/features/home/domain/enitities/current_weather_entity.dart';
import 'package:weather_clean_architecture/features/home/domain/repository/home_repository.dart';

class CurrentWeather extends UseCase<CurrentWeatherEntity, Params> {
  final HomeRepository homeRepository;

  CurrentWeather(this.homeRepository);

  @override
  Future<Either<Failure, CurrentWeatherEntity>> call(Params params) async {
    final response = await homeRepository.getCurrentWeather(params.lat, params.lon);
    return response;
  }
}

class Params {
  final double lat;
  final double lon;

  Params({required this.lat, required this.lon});
}
