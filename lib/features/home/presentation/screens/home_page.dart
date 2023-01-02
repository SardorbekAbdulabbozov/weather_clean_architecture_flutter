import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:weather_clean_architecture/features/home/presentation/bloc/home_bloc.dart';
import 'package:weather_clean_architecture/features/home/presentation/bloc/home_event.dart';
import 'package:weather_clean_architecture/features/home/presentation/bloc/home_state.dart';
import 'package:weather_clean_architecture/features/home/presentation/screens/widgets/hourly_weekly_forecast_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is HomeInitial) {
            context.read<HomeBloc>().add(
                  const CurrentWeatherRefresh(lat: 51.5072, lon: 0.1276),
                );
          }
          return ModalProgressHUD(
            inAsyncCall: state is HomeInitial || state is HomeLoading,
            opacity: 1,
            color: const Color(0xFF45278B),
            progressIndicator: const CircularProgressIndicator(
              color: Colors.white,
            ),
            child: SmartRefresher(
              header: const ClassicHeader(
                refreshStyle: RefreshStyle.Front,
                height: 140,
                idleIcon: Icon(Icons.arrow_downward, color: Colors.white),
                releaseIcon: Icon(Icons.refresh, color: Colors.white),
                textStyle: TextStyle(color: Colors.white),
              ),
              onRefresh: () {
                context.read<HomeBloc>().add(
                      const CurrentWeatherRefresh(lat: 51.5072, lon: 0.1276),
                    );
                // context.read<HomeBloc>().add(
                //       const HourlyForecastPressed(lat: 51.5072, lon: 0.1276),
                //     );
              },
              enablePullDown: true,
              enablePullUp: false,
              enableTwoLevel: false,
              controller: RefreshController(),
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/png/ic_background.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Positioned(
                      top: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            state is HomeLoaded ? state.cityName : '',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 34,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            state is HomeLoaded
                                ? '${state.temperature}\u00b0'
                                : '',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 96,
                              fontWeight: FontWeight.w200,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            state is HomeLoaded ? state.weatherDescription : '',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'H:${state is HomeLoaded ? state.maxTemperature : ''}  L:${state is HomeLoaded ? state.minTemperature : ''}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.34,
                      child: Image.asset(
                        'assets/png/ic_house.png',
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.574,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Positioned(
                            child: GlassContainer(
                              width: MediaQuery.of(context).size.width,
                              height: 400,
                              borderRadius: BorderRadius.circular(44),
                              gradient: LinearGradient(
                                colors: [
                                  const Color.fromARGB(255, 46, 51, 90)
                                      .withOpacity(0.26),
                                  const Color.fromARGB(255, 28, 27, 51)
                                      .withOpacity(0.26),
                                ],
                                begin: const Alignment(0.0, 0.0),
                                end: const Alignment(0.215, 0.977),
                              ),
                              borderGradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.white,
                                  Colors.white,
                                  Colors.white,
                                  Colors.white,
                                  Colors.white,
                                  Colors.white,
                                  Colors.transparent,
                                  Colors.transparent,
                                  Colors.transparent,
                                  Colors.transparent,
                                ],
                              ),
                              blur: 15.0,
                              borderWidth: 0.5,
                              isFrostedGlass: false,
                              alignment: Alignment.center,
                              child: Column(
                                children: [
                                  HourlyForecastWidget(
                                    date: state is HomeLoaded ? state.date : [],
                                    temp: state is HomeLoaded ? state.temp : [],
                                    windSpeed: state is HomeLoaded
                                        ? state.windSpeed
                                        : [],
                                  ),
                                  Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/svg/ic_nav_bar1.svg',
                                        width:
                                            MediaQuery.of(context).size.width,
                                      ),
                                      SvgPicture.asset(
                                        'assets/svg/ic_nav_bar2.svg',
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 380,
                            child: Container(
                              width: 48,
                              height: 5,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
