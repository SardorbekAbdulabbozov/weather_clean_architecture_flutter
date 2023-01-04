import 'package:dartz/dartz.dart';
import 'package:weather_clean_architecture/core/error/failure.dart';
import 'package:weather_clean_architecture/core/usecase/usecase.dart';
import 'package:weather_clean_architecture/features/home/domain/enitities/weekly_forecast_entity.dart';
import 'package:weather_clean_architecture/features/home/domain/repository/home_repository.dart';
import 'package:weather_clean_architecture/features/home/domain/usecases/current_weather.dart';

class WeeklyForecast extends UseCase<WeeklyForecastEntity, Params> {
  final HomeRepository homeRepository;

  WeeklyForecast(this.homeRepository);

  @override
  Future<Either<Failure, WeeklyForecastEntity>> call(Params params) async {
    final response = await homeRepository.getWeeklyForecast(params.lat, params.lon);
    return response;
  }
}