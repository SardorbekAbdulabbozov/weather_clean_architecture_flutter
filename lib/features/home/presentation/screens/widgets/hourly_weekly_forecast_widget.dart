import 'package:flutter/material.dart';

class HourlyWeeklyForecastWidget extends StatelessWidget {
  final List<String> dates;
  final List<double> temps;
  final List<double> windSpeeds;

  const HourlyWeeklyForecastWidget({
    Key? key,
    required this.dates,
    required this.temps,
    required this.windSpeeds,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: const EdgeInsets.all(16).copyWith(top: 19),
      width: MediaQuery.of(context).size.width,
      child: ListView.separated(
        itemCount: dates.length,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (_, index) {
          return const SizedBox(width: 12);
        },
        itemBuilder: (_, i) {
          return Container(
            width: 70,
            decoration: BoxDecoration(
              color: const Color(0xFF45307F),
              borderRadius: BorderRadius.circular(44),
              boxShadow: <BoxShadow>[
                const BoxShadow(
                  color: Color(0x00000000),
                  offset: Offset(5.0, 4.0),
                  blurRadius: 10.0,
                ),
                BoxShadow(
                  color: const Color.fromARGB(255, 255, 255, 255)
                      .withOpacity(0.25),
                  offset: const Offset(0, 0),
                  blurRadius: 1.0,
                ),
              ],
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 32, bottom: 16),
                  child: Text(
                    dates[i],
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
                Image.asset(
                  dates[i].contains('AM')
                      ? (int.tryParse(dates[i].replaceAll(':00 AM', "")) ?? 0) <
                                  6 ||
                              (int.tryParse(dates[i].replaceAll(':00 AM', "")) ??
                                      0) ==
                                  12
                          ? "assets/png/ic_moon_wind.png"
                          : "assets/png/ic_sun_mid_rain.png"
                      : windSpeeds[i] >= 10 && windSpeeds[i] <= 19
                          ? 'assets/png/ic_moon_wind.png'
                          : windSpeeds[i] >= 20
                              ? 'assets/png/ic_moon_wind.png'
                              : 'assets/png/ic_tornado.png',
                  width: 32,
                  height: 32,
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(
                    '${temps[i]}\u00b0',
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      color: Colors.white,
                      letterSpacing: 0.38,
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
