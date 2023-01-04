import 'package:dio/dio.dart';
import 'package:weather_clean_architecture/constants/constants.dart';
import 'package:weather_clean_architecture/core/error/exceptions.dart';
import 'package:weather_clean_architecture/features/weather/data/data_source/remote/weather_remote_data_source.dart';
import 'package:weather_clean_architecture/features/weather/data/models/geocoding_response_model.dart';
import 'package:weather_clean_architecture/features/weather/data/models/weather_response_model.dart';

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final Dio dio;

  WeatherRemoteDataSourceImpl(this.dio);

  var requestOptions = Options(
    contentType: 'application/json',
    sendTimeout: 30,
  );

  @override
  Future<List<GeocodingResponseModel>> getGeocoding(String city) async {
    try {
      final response = await dio.get(
        Constants.BASE_URL_1 + Urls.GEOCODING,
        queryParameters: {
          'q': city,
          'appid': Constants.APP_ID,
          'limit': 1,
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<GeocodingResponseModel> result = [];
        response.data.forEach((element) {
          result.add(GeocodingResponseModel.fromJson(element));
        });
        return result;
      } else {
        throw ServerException.fromJson(response.data);
      }
    } on DioError catch (e) {
      throw ServerException.fromJson(e.response?.data);
    } on FormatException {
      throw ServerException(message: Validations.SOMETHING_WENT_WRONG);
    }
  }

  @override
  Future<WeatherResponseModel> getWeather(double lat, double lon) async {
    try {
      final response = await dio.get(
        Constants.BASE_URL_1 + Urls.CURRENT_WEATHER,
        queryParameters: {
          'lat': lat,
          'lon': lon,
          'appid': Constants.APP_ID,
          'units': 'metric',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return WeatherResponseModel.fromJson(response.data);
      } else {
        throw ServerException.fromJson(response.data);
      }
    } on DioError catch (e) {
      throw ServerException.fromJson(e.response?.data);
    } on FormatException {
      throw ServerException(message: Validations.SOMETHING_WENT_WRONG);
    }
  }
}
