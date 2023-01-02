import 'package:flutter/material.dart';

class HourlyForecastWidget extends StatelessWidget {
  final List<String> date;
  final List<double> temp;
  final List<double> windSpeed;

  const HourlyForecastWidget({
    Key? key,
    required this.date,
    required this.temp,
    required this.windSpeed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: const EdgeInsets.all(16).copyWith(top: 80),
      width: MediaQuery.of(context).size.width,
      child: ListView.separated(
        itemCount: date.length,
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
                    date[i],
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
                Image.asset(
                  date[i].contains('AM')
                      ? (int.tryParse(date[i].replaceAll(':00 AM', "")) ?? 0) <
                                  6 ||
                              (int.tryParse(date[i].replaceAll(':00 AM', "")) ??
                                      0) ==
                                  12
                          ? "assets/png/ic_moon_wind.png"
                          : "assets/png/ic_sun_mid_rain.png"
                      : windSpeed[i] >= 10 && windSpeed[i] <= 19
                          ? 'assets/png/ic_moon_wind.png'
                          : windSpeed[i] >= 20
                              ? 'assets/png/ic_moon_wind.png'
                              : 'assets/png/ic_tornado.png',
                  width: 32,
                  height: 32,
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(
                    '${temp[i]}\u00b0',
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
