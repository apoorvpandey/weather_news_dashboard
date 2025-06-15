import 'package:dio/dio.dart';
import 'package:weather_news_dashboard/core/config/app_environment.dart';

import '../model/forecast_model.dart';
import '../model/weather_model.dart';

class WeatherRemoteDataSource {
  final Dio dio;

  WeatherRemoteDataSource(this.dio);

  Future<WeatherModel> fetchCurrentWeather(String city) async {
    final url = 'https://api.openweathermap.org/data/2.5/weather';
    final response = await dio.get(
      url,
      queryParameters: {
        'q': city,
        'appid': AppEnvironment.openWeatherApiKey,
        'units': 'metric',
      },
    );
    return WeatherModel.fromJson(response.data);
  }

  Future<WeatherModel> fetchCurrentWeatherByCoordinates(
    double lat,
    double lon,
  ) async {
    final url = 'https://api.openweathermap.org/data/2.5/weather';
    final response = await dio.get(
      url,
      queryParameters: {
        'lat': lat,
        'lon': lon,
        'appid': AppEnvironment.openWeatherApiKey,
        'units': 'metric',
      },
    );
    return WeatherModel.fromJson(response.data);
  }

  Future<ForecastModel> fetch5DayForecast(String city) async {
    final url = 'https://api.openweathermap.org/data/2.5/forecast';
    final response = await dio.get(
      url,
      queryParameters: {
        'q': city,
        'appid': AppEnvironment.openWeatherApiKey,
        'units': 'metric',
      },
    );
    return ForecastModel.fromJson(response.data);
  }

  Future<ForecastModel> fetch5DayForecastByCoordinates(
    double lat,
    double lon,
  ) async {
    final url = 'https://api.openweathermap.org/data/2.5/forecast';
    final response = await dio.get(
      url,
      queryParameters: {
        'lat': lat,
        'lon': lon,
        'appid': AppEnvironment.openWeatherApiKey,
        'units': 'metric',
      },
    );
    return ForecastModel.fromJson(response.data);
  }
}
