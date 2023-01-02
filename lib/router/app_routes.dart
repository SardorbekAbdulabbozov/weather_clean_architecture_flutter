import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_clean_architecture/features/home/presentation/screens/home_page.dart';
import 'package:weather_clean_architecture/router/route_names.dart';
import 'package:weather_clean_architecture/features/weather/presentation/weather_page.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final shellRootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: Routes.home,
  routes: [
    GoRoute(
      name: Routes.home,
      path: Routes.home,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      name: Routes.weather,
      path: Routes.weather,
      builder: (context, state) => const WeatherPage(),
    ),
  ],
);
