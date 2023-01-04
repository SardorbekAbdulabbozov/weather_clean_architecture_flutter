import 'package:dartz/dartz.dart';
import 'package:weather_clean_architecture/core/error/failure.dart';
import 'package:weather_clean_architecture/core/usecase/usecase.dart';
import 'package:weather_clean_architecture/features/weather/domain/entities/geocoding_entity.dart';
import 'package:weather_clean_architecture/features/weather/domain/repository/weather_repository.dart';

class Geocoding extends UseCase<List<GeocodingEntity>, Params> {
  final WeatherRepository weatherRepository;

  Geocoding(this.weatherRepository);

  @override
  Future<Either<Failure, List<GeocodingEntity>>> call(Params params) async {
    final response =
        await weatherRepository.getGeocoding(params.city);
    print('response: 111 $response');
    return response;
  }
}

class Params {
  final String city;

  const Params(this.city);
}
