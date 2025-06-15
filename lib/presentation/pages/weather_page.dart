import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/weather_provider/weather_provider.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weather')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: cityController,
              decoration: const InputDecoration(labelText: 'Enter city'),
            ),
            ElevatedButton(
              onPressed: () {
                final city = cityController.text.trim();
                if (city.isNotEmpty) {
                  Provider.of<WeatherProvider>(
                    context,
                    listen: false,
                  ).fetchWeather(city);
                }
              },
              child: const Text('Get Weather'),
            ),
            const SizedBox(height: 32),
            Consumer<WeatherProvider>(
              builder: (context, provider, child) {
                if (provider.state == WeatherState.loading) {
                  return const CircularProgressIndicator();
                } else if (provider.state == WeatherState.loaded &&
                    provider.weather != null) {
                  final weather = provider.weather!;
                  return Column(
                    children: [
                      Text(
                        weather.cityName,
                        style: const TextStyle(fontSize: 24),
                      ),
                      Text('${weather.temperature} °C'),
                      Text(weather.description),
                      Image.network(
                        'https://openweathermap.org/img/wn/${weather.icon}@2x.png',
                        width: 80,
                        height: 80,
                      ),
                    ],
                  );
                } else if (provider.state == WeatherState.error) {
                  return Text('Error: ${provider.error}');
                } else {
                  return const Text('Enter a city to get weather');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
