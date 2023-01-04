import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:weather_clean_architecture/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:weather_clean_architecture/features/weather/presentation/bloc/weather_event.dart';
import 'package:weather_clean_architecture/features/weather/presentation/bloc/weather_state.dart';
import 'package:weather_clean_architecture/features/weather/presentation/screens/widgets/weather_card.dart';
import 'package:weather_clean_architecture/features/weather/presentation/screens/widgets/weather_page_app_bar.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WeatherBloc, WeatherState>(listener: (context, state) {
      if (state is WeatherError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.message),
          ),
        );
      }
    }, builder: (context, state) {
      return Scaffold(
        backgroundColor: const Color(0xFF352F64),
        appBar: WeatherPageAppBar(
          onSearchFieldChanged: (searchKey) {
            if (searchKey.isNotEmpty) {
              context
                  .read<WeatherBloc>()
                  .add(GetWeatherByLocation(city: searchKey));
            }
          },
        ),
        body: state is WeatherInitial
            ? Center(
                child: Text(
                  'To get weather info,\ntype a city name',
                  style: Theme.of(context).textTheme.headline5?.copyWith(
                        color: Colors.white,
                      ),
                  textAlign: TextAlign.center,
                ),
              )
            : ModalProgressHUD(
                inAsyncCall: state is WeatherLoading,
                color: Colors.transparent,
                progressIndicator:
                    const CircularProgressIndicator(color: Colors.white),
                child: ListView.separated(
                  padding: const EdgeInsets.only(top: 21),
                  itemCount: state is WeatherLoading ? 0 : 1,
                  itemBuilder: (_, index) {
                    return WeatherCard(
                      weatherDescription: (state is WeatherSuccess)
                          ? (state.weather?.weatherDescription ?? '')
                          : '',
                      temperature: (state is WeatherSuccess)
                          ? (state.weather?.temperature ?? '')
                          : '',
                      maxTemp: (state is WeatherSuccess)
                          ? (state.weather?.maxTemperature ?? '')
                          : '',
                      minTemp: (state is WeatherSuccess)
                          ? (state.weather?.minTemperature ?? '')
                          : '',
                      cityName: (state is WeatherSuccess)
                          ? ([
                              state.geocoding?.cityName ?? '',
                              state.geocoding?.countryName ?? ''
                            ].join(', '))
                          : '',
                    );
                  },
                  separatorBuilder: (_, index) {
                    return const SizedBox(height: 20);
                  },
                ),
              ),
      );
    });
  }
}
