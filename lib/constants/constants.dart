// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

/// In this app, APIs of two different sources are used
/// 1) OpenWeatherMap API to get current weather data and geocoding: https://openweathermap.org/
/// 2) OpenMeteo API to get weekly and hourly weather forecast data: https://open-meteo.com/

/// UI Design from Figma Community: https://www.figma.com/file/la4jJ1HN6e1OdORGYJQkBu/Weather-App-UI-Design-(Community)?node-id=55%3A2454&t=UaVz1dJkaHKkajnQ-0

class Constants {
  static const String BASE_URL_1 = 'https://api.openweathermap.org/';
  static const String BASE_URL_2 = 'https://api.open-meteo.com/v1/';
  static const String APP_ID = '7f14ede3197cfe591bbae88ed2fb2bf1';
}

class Urls {
  static const String CURRENT_WEATHER = 'data/2.5/weather';
  static const String GEOCODING = 'geo/1.0/direct';
  static const String FORECAST = 'forecast';
}

class DatabaseKeys {
  static const CURRENT_WEATHER = 'currentWeatherDB/';
  static const HOURLY = 'hourlyDB/';
  static const WEEKLY = 'weeklyDB/';
}

class Validations {
  static const SOMETHING_WENT_WRONG = 'Something went wrong!';
}

class WeatherIcons {
  static const List<String> weatherIcons = [
    'assets/png/ic_moon_mid_rain.png',
    'assets/png/ic_moon_wind.png',
    'assets/png/ic_sun_heavy_rain.png',
    'assets/png/ic_sun_mid_rain.png',
    'assets/png/ic_tornado.png',
  ];
}

class Gradients {
  static const cardBorderGradient = [
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
  ];

  static List<Color> cardGradient = [
    const Color.fromARGB(255, 46, 51, 90).withOpacity(0.26),
    const Color.fromARGB(255, 28, 27, 51).withOpacity(0.26),
  ];
}
