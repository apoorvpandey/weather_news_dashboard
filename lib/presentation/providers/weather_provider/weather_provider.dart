import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

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

  Future<void> fetchWeatherByLocation() async {
    _state = WeatherState.loading;
    notifyListeners();

    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _error = 'Location permissions are denied';
          _state = WeatherState.error;
          notifyListeners();
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _error = 'Location permissions are permanently denied';
        _state = WeatherState.error;
        notifyListeners();
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium,
      );

      await fetchWeatherByCoordinates(position.latitude, position.longitude);
    } catch (e) {
      _error = 'Could not fetch location: $e';
      _state = WeatherState.error;
      notifyListeners();
    }
  }

  Future<void> fetchWeatherByCoordinates(double lat, double lon) async {
    _state = WeatherState.loading;
    notifyListeners();

    try {
      final result = await getCurrentWeather.byCoordinates(lat, lon);
      _weather = result;
      _state = WeatherState.loaded;
    } catch (e) {
      _error = e.toString();
      _state = WeatherState.error;
    }
    notifyListeners();
  }
}
