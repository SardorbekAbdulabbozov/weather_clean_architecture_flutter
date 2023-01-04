import 'package:flutter/material.dart';

class HourlyWeeklyTabs extends StatelessWidget {
  const HourlyWeeklyTabs({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final TabController controller;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller,
      indicatorColor: const Color(0xFF7954EC),
      indicatorSize: TabBarIndicatorSize.tab,
      isScrollable: false,
      indicatorPadding: const EdgeInsets.symmetric(horizontal: 40),
      indicatorWeight: 1,
      tabs: [
        Tab(
          child: Text(
            'Hourly Forecast',
            style: TextStyle(
              fontSize: 15,
              color: const Color(0xFFEBEBF5).withOpacity(0.6),
              fontWeight: FontWeight.w600,
              letterSpacing: -0.5,
            ),
          ),
        ),
        Tab(
          child: Text(
            'Weekly Forecast',
            style: TextStyle(
              fontSize: 15,
              color: const Color(0xFFEBEBF5).withOpacity(0.6),
              fontWeight: FontWeight.w600,
              letterSpacing: -0.5,
            ),
          ),
        ),
      ],
    );
  }
}
