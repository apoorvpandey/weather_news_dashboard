import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/weather_provider/weather_provider.dart';
import '../widgets/current_weather_card.dart';
import '../widgets/error_message.dart';
import '../widgets/forecast_list.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/weather_search_bar.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final TextEditingController _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);

    return RefreshIndicator(
      onRefresh: () async {
        if (weatherProvider.weather != null) {
          if (_cityController.text.isNotEmpty) {
            await weatherProvider.refreshWeatherAndForecast(
              city: _cityController.text.trim(),
            );
          } else if (weatherProvider.weather != null) {
            await weatherProvider.refreshWeatherAndForecast(
              city: weatherProvider.weather?.cityName,
            );
          }
        }
      },
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // --- Action Row ---
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Tooltip(
                message: "Get weather for current location",
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(24),
                    onTap: () {
                      weatherProvider.fetchWeatherByLocation();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: Icon(
                        Icons.my_location,
                        size: 28,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // --- Section Title ---
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              'Weather',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          // --- Search Bar ---
          WeatherSearchBar(
            controller: _cityController,
            onSearch: () {
              final city = _cityController.text.trim();
              if (city.isNotEmpty) {
                weatherProvider.fetchWeather(city);
              }
            },
          ),
          const SizedBox(height: 24),
          _buildCurrentWeather(weatherProvider),
          const SizedBox(height: 32),
          const Text(
            '5-Day Forecast',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Divider(height: 24, thickness: 1, color: Colors.black12),
          _buildForecast(weatherProvider),
        ],
      ),
    );
  }

  Widget _buildCurrentWeather(WeatherProvider provider) {
    switch (provider.state) {
      case WeatherState.initial:
        return const Center(child: Text('Enter a city or use your location.'));
      case WeatherState.loading:
        return const LoadingIndicator();
      case WeatherState.error:
        return ErrorMessage(provider.error ?? 'An error occurred');
      case WeatherState.loaded:
        return CurrentWeatherCard(weather: provider.weather!);
    }
  }

  Widget _buildForecast(WeatherProvider provider) {
    switch (provider.forecastState) {
      case WeatherState.initial:
        return const Center(child: Text('No forecast yet.'));
      case WeatherState.loading:
        return const LoadingIndicator();
      case WeatherState.error:
        return ErrorMessage(
          provider.forecastError ?? 'Could not load forecast',
        );
      case WeatherState.loaded:
        if (provider.forecast.isEmpty) {
          return const Center(child: Text('No forecast data found.'));
        }
        return ForecastList(forecast: provider.forecast);
    }
  }

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }
}
