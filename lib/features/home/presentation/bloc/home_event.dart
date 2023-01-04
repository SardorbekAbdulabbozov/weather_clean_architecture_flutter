import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class FetchHomeData extends HomeEvent {

  final double lat;
  final double lon;

  const FetchHomeData({
    required this.lat,
    required this.lon,
  });
  @override
  List<Object?> get props => [];
}