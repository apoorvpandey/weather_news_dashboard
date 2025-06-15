class ForecastItemModel {
  final DateTime dateTime;
  final double temperature;
  final String weatherDescription;
  final String icon;

  ForecastItemModel({
    required this.dateTime,
    required this.temperature,
    required this.weatherDescription,
    required this.icon,
  });

  factory ForecastItemModel.fromJson(Map<String, dynamic> json) {
    return ForecastItemModel(
      dateTime: DateTime.parse(json['dt_txt']),
      temperature: (json['main']['temp'] as num).toDouble(),
      weatherDescription: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
    );
  }
}
