import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:weather_clean_architecture/constants/constants.dart';
import 'package:weather_clean_architecture/features/home/presentation/bloc/home_bloc.dart';
import 'package:weather_clean_architecture/features/home/presentation/bloc/home_event.dart';
import 'package:weather_clean_architecture/features/home/presentation/bloc/home_state.dart';
import 'package:weather_clean_architecture/features/home/presentation/screens/widgets/forecast_widget.dart';
import 'package:weather_clean_architecture/router/route_names.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HomeHourlyForecastError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          } else if (state is HomeWeeklyForecastError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          } else if (state is HomeCurrentWeatherError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          } else {}
        },
        builder: (context, state) {
          if (state is HomeInitial) {
            context.read<HomeBloc>().add(
                  const FetchHomeData(
                    lat: 41.26465,
                    lon: 69.21627,
                  ),
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
              footer: const SizedBox.shrink(),
              onRefresh: () {
                context.read<HomeBloc>().add(
                      const FetchHomeData(
                        lat: 41.26465,
                        lon: 69.21627,
                      ),
                    );
              },
              physics: const ClampingScrollPhysics(),
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
                            state is HomeSuccess
                                ? (state.currentWeather?.cityName) ?? ""
                                : '',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 34,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            state is HomeSuccess
                                ? '${state.currentWeather?.temperature ?? 0}\u00b0'
                                : '',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 96,
                              fontWeight: FontWeight.w200,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            state is HomeSuccess
                                ? (state.currentWeather?.weatherDescription ??
                                    '')
                                : '',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'H:${state is HomeSuccess ? (state.currentWeather?.maxTemperature ?? "0") : ''}  L:${state is HomeSuccess ? (state.currentWeather?.minTemperature ?? '0') : ''}',
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
                      top: MediaQuery.of(context).size.height * 0.560,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Positioned(
                            child: GlassContainer(
                              width: MediaQuery.of(context).size.width,
                              height: 470,
                              borderRadius: BorderRadius.circular(44),
                              gradient: LinearGradient(
                                colors: Gradients.cardGradient,
                                begin: const Alignment(0.0, 0.0),
                                end: const Alignment(0.215, 0.977),
                              ),
                              borderGradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: Gradients.cardBorderGradient,
                              ),
                              blur: 15.0,
                              borderWidth: 0.5,
                              isFrostedGlass: false,
                              alignment: Alignment.center,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 42, bottom: 20),
                                    child: ForecastWidget(
                                      hDates: state is HomeSuccess
                                          ? state.hourlyForecast?.dates ?? []
                                          : [],
                                      hTemps: state is HomeSuccess
                                          ? state.hourlyForecast?.temps ?? []
                                          : [],
                                      hWindSpeeds: state is HomeSuccess
                                          ? state.hourlyForecast?.windSpeeds ??
                                              []
                                          : [],
                                      wDates: state is HomeSuccess
                                          ? state.weeklyForecast?.dates ?? []
                                          : [],
                                      wTemps: state is HomeSuccess
                                          ? state.weeklyForecast?.temps ?? []
                                          : [],
                                      wWindSpeeds: state is HomeSuccess
                                          ? state.weeklyForecast?.windSpeeds ??
                                              []
                                          : [],
                                    ),
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
                                      Positioned(
                                        right: 32,
                                        bottom: 8,
                                        child: InkWell(
                                          onTap: () {
                                            context.pushNamed(Routes.weather);
                                          },
                                          child: const CircleAvatar(
                                            backgroundColor: Colors.transparent,
                                            radius: 36,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 446,
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
