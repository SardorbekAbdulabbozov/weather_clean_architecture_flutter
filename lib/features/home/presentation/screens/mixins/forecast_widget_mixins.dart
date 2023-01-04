import 'package:flutter/material.dart';

mixin ForecastWidgetMixin {
  late TabController tabController;

  void initTabController(TickerProvider tickerProvider) {
    tabController = TabController(length: 2, vsync: tickerProvider);
  }

  void disposeTabController() {
    tabController.dispose();
  }
}