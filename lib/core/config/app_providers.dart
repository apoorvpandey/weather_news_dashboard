import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../data/datasources/weather_remote_datasource.dart';
import '../../domain/repositories/weather_repository_impl.dart';
import '../../domain/usecases/get_current_weather.dart';
import '../../presentation/providers/news_provider.dart';
import '../../presentation/providers/theme_provider/theme_provider.dart';
import '../../presentation/providers/weather_provider/weather_provider.dart';

List<SingleChildWidget> appProviders() {
  final dio = Dio();
  final weatherRemoteDataSource = WeatherRemoteDataSource(dio);
  final weatherRepository = WeatherRepositoryImpl(weatherRemoteDataSource);
  final getCurrentWeather = GetCurrentWeather(weatherRepository);

  return [
    ChangeNotifierProvider(create: (_) => WeatherProvider(getCurrentWeather)),
    ChangeNotifierProvider(create: (_) => NewsProvider()),
    ChangeNotifierProvider(create: (_) => ThemeProvider()),
  ];
}
