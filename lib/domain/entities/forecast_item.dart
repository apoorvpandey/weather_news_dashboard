class ForecastItem {
  final DateTime dateTime;
  final double temperature;
  final String weatherDescription;
  final String icon;

  ForecastItem({
    required this.dateTime,
    required this.temperature,
    required this.weatherDescription,
    required this.icon,
  });
}
