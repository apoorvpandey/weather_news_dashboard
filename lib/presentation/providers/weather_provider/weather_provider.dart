import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../../../domain/entities/forecast_item.dart';
import '../../../domain/entities/weather.dart';
import '../../../domain/usecases/get_current_weather.dart';
import '../../../domain/usecases/get_forecast.dart';

enum WeatherState { initial, loading, loaded, error }

class WeatherProvider extends ChangeNotifier {
  final GetCurrentWeather getCurrentWeather;
  final GetForecast getForecast;

  WeatherProvider(this.getCurrentWeather, this.getForecast);

  WeatherState _state = WeatherState.initial;

  WeatherState get state => _state;

  Weather? _weather;

  Weather? get weather => _weather;

  String? _error;

  String? get error => _error;

  List<ForecastItem> _forecast = [];

  List<ForecastItem> get forecast => _forecast;

  WeatherState _forecastState = WeatherState.initial;

  WeatherState get forecastState => _forecastState;

  String? _forecastError;

  String? get forecastError => _forecastError;

  Future<void> fetchWeather(String city) async {
    _state = WeatherState.loading;
    _error = null;
    notifyListeners();

    try {
      final result = await getCurrentWeather.call(city);
      _weather = result;
      _state = WeatherState.loaded;

      await fetchForecast(city);
    } catch (e) {
      _error = e.toString();
      _state = WeatherState.error;
      notifyListeners();
    }
  }

  Future<void> fetchWeatherByLocation() async {
    _state = WeatherState.loading;
    _error = null;
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
    _error = null;
    notifyListeners();

    try {
      final result = await getCurrentWeather.byCoordinates(lat, lon);
      _weather = result;
      _state = WeatherState.loaded;
      await fetchForecastByCoordinates(lat, lon);
    } catch (e) {
      _error = e.toString();
      _state = WeatherState.error;
      notifyListeners();
    }
  }

  Future<void> fetchForecast(String city) async {
    _forecastState = WeatherState.loading;
    _forecastError = null;
    notifyListeners();

    try {
      _forecast = await getForecast.call(city);
      _forecastState = WeatherState.loaded;
      notifyListeners();
    } catch (e) {
      _forecastError = e.toString();
      _forecastState = WeatherState.error;
      notifyListeners();
    }
  }

  Future<void> fetchForecastByCoordinates(double lat, double lon) async {
    _forecastState = WeatherState.loading;
    _forecastError = null;
    notifyListeners();

    try {
      _forecast = await getForecast.callByCoordinates(lat, lon);
      _forecastState = WeatherState.loaded;
      notifyListeners();
    } catch (e) {
      _forecastError = e.toString();
      _forecastState = WeatherState.error;
      notifyListeners();
    }
  }

  Future<void> refreshWeatherAndForecast({
    String? city,
    double? lat,
    double? lon,
  }) async {
    if (city != null) {
      await fetchWeather(city);
    } else if (lat != null && lon != null) {
      await fetchWeatherByCoordinates(lat, lon);
    }
  }
}
