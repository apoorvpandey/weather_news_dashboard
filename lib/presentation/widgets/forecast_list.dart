import 'package:flutter/material.dart';

import '../../domain/entities/forecast_item.dart';
import 'forecast_card.dart';

class ForecastList extends StatelessWidget {
  final List<ForecastItem> forecast;

  const ForecastList({required this.forecast, super.key});

  @override
  Widget build(BuildContext context) {
    // Show only one per day at 12:00
    final filtered = forecast
        .where((item) => item.dateTime.hour == 12)
        .toList();
    return SizedBox(
      height: 180,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: filtered.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          return ForecastCard(item: filtered[index]);
        },
      ),
    );
  }
}
