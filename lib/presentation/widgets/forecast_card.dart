import 'package:flutter/material.dart';
import '../../domain/entities/forecast_item.dart';

class ForecastCard extends StatelessWidget {
  final ForecastItem item;

  const ForecastCard({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        width: 110,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${item.dateTime.day}/${item.dateTime.month}',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            Text('${item.dateTime.hour}:00'),
            Image.network(
              'https://openweathermap.org/img/wn/${item.icon}@2x.png',
              width: 50,
              height: 50,
            ),
            Text(
              '${item.temperature.toStringAsFixed(1)}°C',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              item.weatherDescription,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}