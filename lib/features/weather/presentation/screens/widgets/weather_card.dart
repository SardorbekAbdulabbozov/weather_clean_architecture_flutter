import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_clean_architecture/constants/constants.dart';

class WeatherCard extends StatelessWidget {
  const WeatherCard({
    Key? key,
    required this.weatherDescription,
    required this.temperature,
    required this.maxTemp,
    required this.minTemp,
    required this.cityName,
  }) : super(key: key);
  final String weatherDescription;
  final String temperature;
  final String maxTemp;
  final String minTemp;
  final String cityName;

  @override
  Widget build(BuildContext context) {
    final Random randomNumGen = Random();
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: 220,
          child: SvgPicture.asset(
            'assets/svg/ic_city_card.svg',
            width: MediaQuery.of(context).size.width - 48,
          ),
        ),
        Positioned(
          top: -10,
          right: 45,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Image.asset(
                WeatherIcons.weatherIcons[randomNumGen.nextInt(
                  WeatherIcons.weatherIcons.length,
                )],
                width: 160,
                height: 160,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18, right: 24),
                child: Text(
                  weatherDescription,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    letterSpacing: -0.08,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 48,
          left: 45,
          child: Text(
            '$temperature\u00B0',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 64,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.37,
            ),
          ),
        ),
        Positioned(
          top: 140,
          left: 48,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'H: $maxTemp\u00B0 L: $minTemp\u00B0',
                style: TextStyle(
                  color: const Color(0xFFEBEBF5).withOpacity(0.6),
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  letterSpacing: -0.08,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                cityName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  letterSpacing: -0.41,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
