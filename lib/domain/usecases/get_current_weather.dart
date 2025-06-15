import '../entities/weather.dart';
import '../repositories/weather_repository.dart';

class GetCurrentWeather {
  final WeatherRepository repository;

  GetCurrentWeather(this.repository);

  Future<Weather> call(String city) {
    return repository.getCurrentWeather(city);
  }

  Future<Weather> byCoordinates(double lat, double lon) {
    return repository.getCurrentWeatherByCoordinates(lat, lon);
  }
}
