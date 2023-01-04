import 'package:bloc/bloc.dart';
import 'package:weather_clean_architecture/features/home/domain/enitities/current_weather_entity.dart';
import 'package:weather_clean_architecture/features/home/domain/enitities/hourly_forecast_entity.dart';
import 'package:weather_clean_architecture/features/home/domain/enitities/weekly_forecast_entity.dart';
import 'package:weather_clean_architecture/features/home/domain/usecases/current_weather.dart';
import 'package:weather_clean_architecture/features/home/domain/usecases/hourly_forecast.dart';
import 'package:weather_clean_architecture/features/home/domain/usecases/weekly_forecast.dart';
import 'package:weather_clean_architecture/features/home/presentation/bloc/home_event.dart';
import 'package:weather_clean_architecture/features/home/presentation/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final CurrentWeather currentWeather;
  final HourlyForecast hourlyForecast;
  final WeeklyForecast weeklyForecast;

  HomeBloc({
    required this.currentWeather,
    required this.hourlyForecast,
    required this.weeklyForecast,
  }) : super(HomeInitial()) {
    on<FetchHomeData>(_fetchHomeData);
  }

  Future<void> _fetchHomeData(
    FetchHomeData event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    CurrentWeatherEntity? currentWeatherEntity;
    HourlyForecastEntity? hourlyForecastEntity;
    WeeklyForecastEntity? weeklyForecastEntity;
    final responseH =
        await hourlyForecast(Params(lat: event.lat, lon: event.lon));
    final responseC =
        await currentWeather(Params(lat: event.lat, lon: event.lon));
    final responseW =
        await weeklyForecast(Params(lat: event.lat, lon: event.lon));
    responseH.fold(
      (failure) {
        emit(
          const HomeHourlyForecastError(
            message: 'Hourly weather cannot be loaded due to unexpected error',
          ),
        );
      },
      (data) {
        hourlyForecastEntity = data;
      },
    );
    responseC.fold(
      (failure) {
        emit(
          const HomeCurrentWeatherError(
            message: 'Current weather cannot be loaded due to unexpected error',
          ),
        );
      },
      (data) {
        currentWeatherEntity = data;
      },
    );
    responseW.fold(
      (failure) {
        emit(
          const HomeWeeklyForecastError(
            message: 'Weekly weather cannot be loaded due to unexpected error',
          ),
        );
      },
      (data) {
        weeklyForecastEntity = data;
        emit(
          HomeSuccess(
            currentWeather: currentWeatherEntity,
            hourlyForecast: hourlyForecastEntity,
            weeklyForecast: weeklyForecastEntity,
          ),
        );
      },
    );
  }
}
