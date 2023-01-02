import 'package:dartz/dartz.dart';
import 'package:weather_clean_architecture/core/error/failure.dart';
import 'package:weather_clean_architecture/core/usecase/usecase.dart';
import 'package:weather_clean_architecture/features/home/domain/enitities/hourly_forecast_entity.dart';
import 'package:weather_clean_architecture/features/home/domain/repository/home_repository.dart';
import 'package:weather_clean_architecture/features/home/domain/usecases/current_weather.dart';

class HourlyForecast extends UseCase<HourlyForecastEntity, Params> {
  final HomeRepository homeRepository;

  HourlyForecast(this.homeRepository);

  @override
  Future<Either<Failure, HourlyForecastEntity>> call(Params params) async {
    final response = await homeRepository.getHourlyForecast(params.lat, params.lon);
    return response;
  }
}