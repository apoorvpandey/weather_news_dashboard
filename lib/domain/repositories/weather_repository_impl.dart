import '../../data/datasources/weather_remote_datasource.dart';
import '../../data/model/weather_model.dart';
import '../../domain/entities/weather.dart';
import '../../domain/repositories/weather_repository.dart';

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
}
