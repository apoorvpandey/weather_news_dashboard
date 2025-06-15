import '../entities/forecast_item.dart';
import '../entities/weather.dart';

abstract class WeatherRepository {
  Future<Weather> getCurrentWeather(String city);

  Future<Weather> getCurrentWeatherByCoordinates(double lat, double lon);

  Future<List<ForecastItem>> get5DayForecast(String city);

  Future<List<ForecastItem>> get5DayForecastByCoordinates(
    double lat,
    double lon,
  );
}
