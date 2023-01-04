import 'package:equatable/equatable.dart';

class GeocodingEntity extends Equatable {
  final String cityName;
  final String countryName;
  final double latitude;
  final double longitude;

  const GeocodingEntity({
    required this.cityName,
    required this.countryName,
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object?> get props => [
        cityName,
        countryName,
        latitude,
        longitude,
      ];
}