import '../../data/datasources/remote/weather_remote_datasource.dart';
import '../../data/model/forecast_model.dart';
import '../../data/model/weather_model.dart';
import '../../domain/entities/weather.dart';
import '../../domain/repositories/weather_repository.dart';
import '../entities/forecast_item.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;

  WeatherRepositoryImpl(this.remoteDataSource);

  @override
  Future<Weather> getCurrentWeather(String city) async {
    final WeatherModel model = await remoteDataSource.fetchCurrentWeather(city);
    return Weather(
      cityName: model.cityName,
      temperature: model.temperature,
      description: model.description,
      icon: model.icon,
      dateTime: model.dateTime,
    );
  }

  @override
  Future<Weather> getCurrentWeatherByCoordinates(double lat, double lon) async {
    final WeatherModel model = await remoteDataSource
        .fetchCurrentWeatherByCoordinates(lat, lon);
    return Weather(
      cityName: model.cityName,
      temperature: model.temperature,
      description: model.description,
      icon: model.icon,
      dateTime: model.dateTime,
    );
  }

  @override
  Future<List<ForecastItem>> get5DayForecast(String city) async {
    final ForecastModel forecastModel = await remoteDataSource
        .fetch5DayForecast(city);
    return forecastModel.items
        .map(
          (item) => ForecastItem(
            dateTime: item.dateTime,
            temperature: item.temperature,
            weatherDescription: item.weatherDescription,
            icon: item.icon,
          ),
        )
        .toList();
  }

  @override
  Future<List<ForecastItem>> get5DayForecastByCoordinates(
    double lat,
    double lon,
  ) async {
    final ForecastModel forecastModel = await remoteDataSource
        .fetch5DayForecastByCoordinates(lat, lon);
    return forecastModel.items
        .map(
          (item) => ForecastItem(
            dateTime: item.dateTime,
            temperature: item.temperature,
            weatherDescription: item.weatherDescription,
            icon: item.icon,
          ),
        )
        .toList();
  }
}
