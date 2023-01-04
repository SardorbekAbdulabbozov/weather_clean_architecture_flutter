import 'package:flutter/material.dart';
import 'package:weather_clean_architecture/features/home/presentation/screens/mixins/forecast_widget_mixins.dart';
import 'package:weather_clean_architecture/features/home/presentation/screens/widgets/hourly_weekly_forecast_widget.dart';
import 'package:weather_clean_architecture/features/home/presentation/screens/widgets/hourly_weekly_tabs.dart';

class ForecastWidget extends StatefulWidget {
  const ForecastWidget({
    Key? key,
    required this.hDates,
    required this.hTemps,
    required this.hWindSpeeds,
    required this.wDates,
    required this.wTemps,
    required this.wWindSpeeds,
  }) : super(key: key);

  final List<String> hDates;
  final List<double> hTemps;
  final List<double> hWindSpeeds;

  final List<String> wDates;
  final List<double> wTemps;
  final List<double> wWindSpeeds;

  @override
  State<ForecastWidget> createState() => _ForecastWidgetState();
}

class _ForecastWidgetState extends State<ForecastWidget>
    with ForecastWidgetMixin, TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    initTabController(this);
  }

  @override
  void dispose() {
    super.dispose();
    disposeTabController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HourlyWeeklyTabs(controller: tabController),
        const Divider(thickness: 1.5, height: 1),
        SizedBox(
          height: 200,
          child: TabBarView(
            controller: tabController,
            children: [
              HourlyWeeklyForecastWidget(
                dates: widget.hDates,
                temps: widget.hTemps,
                windSpeeds: widget.hWindSpeeds,
              ),
              HourlyWeeklyForecastWidget(
                dates: widget.wDates,
                temps: widget.wTemps,
                windSpeeds: widget.wWindSpeeds,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
