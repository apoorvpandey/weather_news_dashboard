import '../entities/forecast_item.dart';
import '../repositories/weather_repository.dart';

class GetForecast {
  final WeatherRepository repository;

  GetForecast(this.repository);

  Future<List<ForecastItem>> call(String city) {
    return repository.get5DayForecast(city);
  }

  Future<List<ForecastItem>> callByCoordinates(double lat, double lon) {
    return repository.get5DayForecastByCoordinates(lat, lon);
  }
}