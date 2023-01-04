import 'package:weather_clean_architecture/features/weather/domain/entities/geocoding_entity.dart';

class GeocodingResponseModel {
  String? name;
  double? lat;
  double? lon;
  String? country;
  String? state;

  GeocodingResponseModel({
    this.name,
    this.lat,
    this.lon,
    this.country,
    this.state,
  });

  GeocodingResponseModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    lat = json['lat'];
    lon = json['lon'];
    country = json['country'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['lat'] = lat;
    data['lon'] = lon;
    data['country'] = country;
    data['state'] = state;
    return data;
  }
}

extension GeocodingExtension on GeocodingResponseModel {
  GeocodingEntity toEntity() {
    return GeocodingEntity(
      cityName: name ?? "",
      countryName: country ?? "",
      latitude: lat ?? 0.0,
      longitude: lon ?? 0.0,
    );
  }
}
