import 'package:flutter/material.dart';

import '../../../domain/entities/weather.dart';
import '../../../domain/usecases/get_current_weather.dart';

enum WeatherState { initial, loading, loaded, error }

class WeatherProvider extends ChangeNotifier {
  final GetCurrentWeather getCurrentWeather;

  WeatherProvider(this.getCurrentWeather);

  WeatherState _state = WeatherState.initial;
  WeatherState get state => _state;

  Weather? _weather;
  Weather? get weather => _weather;

  String? _error;
  String? get error => _error;

  Future<void> fetchWeather(String city) async {
    _state = WeatherState.loading;
    notifyListeners();

    try {
      final result = await getCurrentWeather(city);
      _weather = result;
      _state = WeatherState.loaded;
    } catch (e) {
      _error = e.toString();
      _state = WeatherState.error;
    }
    notifyListeners();
  }
}