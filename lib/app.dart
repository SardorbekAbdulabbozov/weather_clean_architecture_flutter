import 'package:flutter/material.dart';
import 'package:weather_clean_architecture/router/app_routes.dart';

class WeatherApp extends StatelessWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp.router(
      title: 'Weather App',
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
