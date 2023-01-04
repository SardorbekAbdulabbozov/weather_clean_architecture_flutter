import 'package:jiffy/jiffy.dart';
import 'package:weather_clean_architecture/features/home/domain/enitities/weekly_forecast_entity.dart';

class WeeklyForecastResponseModel {
  double? latitude;
  double? longitude;
  double? generationtimeMs;
  num? utcOffsetSeconds;
  String? timezone;
  String? timezoneAbbreviation;
  num? elevation;
  DailyUnits? dailyUnits;
  Daily? daily;

  WeeklyForecastResponseModel({
    this.latitude,
    this.longitude,
    this.generationtimeMs,
    this.utcOffsetSeconds,
    this.timezone,
    this.timezoneAbbreviation,
    this.elevation,
    this.dailyUnits,
    this.daily,
  });

  WeeklyForecastResponseModel.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    generationtimeMs = json['generationtime_ms'];
    utcOffsetSeconds = json['utc_offset_seconds'];
    timezone = json['timezone'];
    timezoneAbbreviation = json['timezone_abbreviation'];
    elevation = json['elevation'];
    dailyUnits = json['daily_units'] != null
        ? DailyUnits.fromJson(json['daily_units'])
        : null;
    daily = json['daily'] != null ? Daily.fromJson(json['daily']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['generationtime_ms'] = generationtimeMs;
    data['utc_offset_seconds'] = utcOffsetSeconds;
    data['timezone'] = timezone;
    data['timezone_abbreviation'] = timezoneAbbreviation;
    data['elevation'] = elevation;
    if (dailyUnits != null) {
      data['daily_units'] = dailyUnits!.toJson();
    }
    if (daily != null) {
      data['daily'] = daily!.toJson();
    }
    return data;
  }
}

class DailyUnits {
  String? time;
  String? temperature2mMax;
  String? temperature2mMin;
  String? rainSum;
  String? windspeed10mMax;

  DailyUnits(
      {this.time,
      this.temperature2mMax,
      this.temperature2mMin,
      this.rainSum,
      this.windspeed10mMax});

  DailyUnits.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    temperature2mMax = json['temperature_2m_max'];
    temperature2mMin = json['temperature_2m_min'];
    rainSum = json['rain_sum'];
    windspeed10mMax = json['windspeed_10m_max'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['time'] = time;
    data['temperature_2m_max'] = temperature2mMax;
    data['temperature_2m_min'] = temperature2mMin;
    data['rain_sum'] = rainSum;
    data['windspeed_10m_max'] = windspeed10mMax;
    return data;
  }
}

class Daily {
  List<String>? time;
  List<double>? temperatureMax;
  List<double>? temperatureMin;
  List<double>? rainSum;
  List<double>? windSpeedMax;

  Daily(
      {this.time,
      this.temperatureMax,
      this.temperatureMin,
      this.rainSum,
      this.windSpeedMax});

  Daily.fromJson(Map<String, dynamic> json) {
    time = json['time'].cast<String>();
    temperatureMax = json['temperature_2m_max'].cast<double>();
    temperatureMin = json['temperature_2m_min'].cast<double>();
    rainSum = json['rain_sum'].cast<double>();
    windSpeedMax = json['windspeed_10m_max'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['time'] = time;
    data['temperature_2m_max'] = temperatureMax;
    data['temperature_2m_min'] = temperatureMin;
    data['rain_sum'] = rainSum;
    data['windspeed_10m_max'] = windSpeedMax;
    return data;
  }
}

extension WeeklyForecastExtension on WeeklyForecastResponseModel {
  WeeklyForecastEntity toEntity() {
    List<String> dates = [];
    List<double> temps = [];
    List<double> windSpeeds = [];
    for (int i = 0; i < (daily?.time ?? []).length; i++) {
      dates.add(Jiffy(daily?.time?[i]).format('d MMM'));
      temps.add((((daily?.temperatureMax?[i] ?? 0) +
              (daily?.temperatureMin?[i] ?? 0)) /
          2).roundToDouble());
      windSpeeds.add(daily?.windSpeedMax?[i] ?? 0);
    }
    return WeeklyForecastEntity(
      dates: dates,
      windSpeeds: windSpeeds,
      temps: temps,
    );
  }
}
