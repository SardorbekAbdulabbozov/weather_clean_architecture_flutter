import 'package:bloc/bloc.dart';
import 'package:weather_clean_architecture/features/weather/domain/entities/geocoding_entity.dart';
import 'package:weather_clean_architecture/features/weather/domain/entities/weather_entity.dart';
import 'package:weather_clean_architecture/features/weather/domain/usecases/geocoding.dart'
    as g;
import 'package:weather_clean_architecture/features/weather/domain/usecases/weather.dart';
import 'package:weather_clean_architecture/features/weather/presentation/bloc/weather_event.dart';
import 'package:weather_clean_architecture/features/weather/presentation/bloc/weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final Weather weather;
  final g.Geocoding geocoding;

  WeatherBloc({
    required this.weather,
    required this.geocoding,
  }) : super(WeatherInitial()) {
    on<GetWeatherByLocation>(_getWeatherByLocation);
  }

  Future<void> _getWeatherByLocation(
    GetWeatherByLocation event,
    Emitter<WeatherState> emit,
  ) async {
    emit(WeatherLoading());
    GeocodingEntity? geocodingEntity;
    WeatherEntity? weatherEntity;
    final responseG = await geocoding(g.Params(event.city));
    await responseG.fold(
      (failure) {
        emit(
          const WeatherError(message: 'Something went wrong'),
        );
      },
      (data) async {
        if (data.isEmpty) {
          emit(WeatherInitial());
        } else {
          geocodingEntity = data.first;
          final responseW = await weather(
            Params(
                lat: geocodingEntity?.latitude ?? 0.0,
                lon: geocodingEntity?.longitude ?? 0.0),
          );
          responseW.fold(
            (failure) {
              emit(
                const WeatherError(
                  message: 'Something went wrong',
                ),
              );
            },
            (data) {
              weatherEntity = data;
              emit(
                WeatherSuccess(
                  weather: weatherEntity,
                  geocoding: geocodingEntity,
                ),
              );
            },
          );
        }
      },
    );
  }
}
