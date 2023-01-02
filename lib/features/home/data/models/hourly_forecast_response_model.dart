import 'package:jiffy/jiffy.dart';
import 'package:weather_clean_architecture/features/home/domain/enitities/hourly_forecast_entity.dart';

class HourlyForecastResponseModel {
  double? latitude;
  double? longitude;
  double? generationtimeMs;
  num? utcOffsetSeconds;
  String? timezone;
  String? timezoneAbbreviation;
  num? elevation;
  HourlyUnits? hourlyUnits;
  Hourly? hourly;

  HourlyForecastResponseModel({
    this.latitude,
    this.longitude,
    this.generationtimeMs,
    this.utcOffsetSeconds,
    this.timezone,
    this.timezoneAbbreviation,
    this.elevation,
    this.hourlyUnits,
    this.hourly,
  });

  HourlyForecastResponseModel.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    generationtimeMs = json['generationtime_ms'];
    utcOffsetSeconds = json['utc_offset_seconds'];
    timezone = json['timezone'];
    timezoneAbbreviation = json['timezone_abbreviation'];
    elevation = json['elevation'];
    hourlyUnits = json['hourly_units'] != null
        ? HourlyUnits.fromJson(json['hourly_units'])
        : null;
    hourly = json['hourly'] != null ? Hourly.fromJson(json['hourly']) : null;
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
    if (hourlyUnits != null) {
      data['hourly_units'] = hourlyUnits!.toJson();
    }
    if (hourly != null) {
      data['hourly'] = hourly!.toJson();
    }
    return data;
  }
}

class HourlyUnits {
  String? time;
  String? temperature;
  String? windspeed;

  HourlyUnits({this.time, this.temperature, this.windspeed});

  HourlyUnits.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    temperature = json['temperature_2m'];
    windspeed = json['windspeed_10m'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['time'] = time;
    data['temperature_2m'] = temperature;
    data['windspeed_10m'] = windspeed;
    return data;
  }
}

class Hourly {
  List<String>? time;
  List<double>? temperature;
  List<double>? windspeed;

  Hourly({this.time, this.temperature, this.windspeed});

  Hourly.fromJson(Map<String, dynamic> json) {
    time = json['time'].cast<String>();
    temperature = json['temperature_2m'].cast<double>();
    windspeed = json['windspeed_10m'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['time'] = time;
    data['temperature_2m'] = temperature;
    data['windspeed_10m'] = windspeed;
    return data;
  }
}

extension HourlyForecastExtension on HourlyForecastResponseModel {
  HourlyForecastEntity toEntity() {
    List<String> date = [];
    List<double> temps = [];
    List<double> windSpeeds = [];
    for (int i = 0; i < (hourly?.time ?? []).length; i++) {
      if (Jiffy(hourly?.time?[i]).isAfter(DateTime.now().toString()) &&
          Jiffy(hourly?.time?[i]).isBefore(DateTime.now().add(const Duration(days: 1)).toString())) {
        date.add(Jiffy(hourly?.time?[i]).format('h:mm a'));
        temps.add(hourly?.temperature?[i]??0);
        windSpeeds.add(hourly?.windspeed?[i]??0);
      }
    }
    return HourlyForecastEntity(
      date: date,
      temps: temps,
      windSpeeds: windSpeeds,
    );
  }
}
