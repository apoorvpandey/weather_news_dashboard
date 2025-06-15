import '../entities/weather.dart';

abstract class WeatherRepository {
  Future<Weather> getCurrentWeather(String city);

  Future<Weather> getCurrentWeatherByCoordinates(double lat, double lon);
}
