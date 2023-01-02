import 'package:bloc/bloc.dart';
import 'package:weather_clean_architecture/constants/constants.dart';
import 'package:weather_clean_architecture/core/error/failure.dart';
import 'package:weather_clean_architecture/features/home/domain/usecases/current_weather.dart';
import 'package:weather_clean_architecture/features/home/domain/usecases/hourly_forecast.dart';
import 'package:weather_clean_architecture/features/home/presentation/bloc/home_event.dart';
import 'package:weather_clean_architecture/features/home/presentation/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final CurrentWeather currentWeather;
  final HourlyForecast hourlyForecast;

  HomeBloc({
    required this.currentWeather,
    required this.hourlyForecast,
  }) : super(HomeInitial()) {
    on<CurrentWeatherRefresh>(_currentWeatherRefreshHandler);
    on<HourlyForecastPressed>(_getHourlyForecast);
  }

  void _currentWeatherRefreshHandler(
      CurrentWeatherRefresh event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    final responseH =
        await hourlyForecast(Params(lat: event.lat, lon: event.lon));
    final response =
        await currentWeather(Params(lat: event.lat, lon: event.lon));
    response.fold(
      (failure) => emit(
        HomeError(
            message: (failure is ServerFailure)
                ? failure.message
                : Validations.SOMETHING_WENT_WRONG),
      ),
      (weather) {
        var homeLoaded = HomeLoaded(
          cityName: weather.cityName,
          temperature: weather.temperature,
          weatherDescription: weather.weatherDescription,
          maxTemperature: weather.maxTemperature,
          minTemperature: weather.minTemperature,
          date: const [],
          temp: const [],
          windSpeed: const [],
        );
        responseH.fold(
          (failure) {
            emit(
              HomeError(
                  message: (failure is ServerFailure)
                      ? failure.message
                      : Validations.SOMETHING_WENT_WRONG),
            );
          },
          (forecast) {
            homeLoaded = homeLoaded.copyWith(
              date: forecast.date,
              temp: forecast.temps,
              windSpeed: forecast.windSpeeds,
            );
          },
        );
        emit(homeLoaded);
      },
    );
  }

  void _getHourlyForecast(
      HourlyForecastPressed event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    final response =
        await hourlyForecast(Params(lat: event.lat, lon: event.lon));
    response.fold(
      (failure) {
        emit(
          HomeError(
              message: (failure is ServerFailure)
                  ? failure.message
                  : Validations.SOMETHING_WENT_WRONG),
        );
      },
      (weather) {
        emit(
          HourlyForecastLoaded(
            date: weather.date,
            temp: weather.temps,
            windSpeed: weather.windSpeeds,
          ),
        );
      },
    );
  }
}
