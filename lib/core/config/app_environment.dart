import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppEnvironment {
  static late final String openWeatherApiKey;
  static late final String newsApiKey;

  static void setupEnv() {
    openWeatherApiKey = dotenv.env['OPEN_WEATHER_API_KEY'] ?? '';
    newsApiKey = dotenv.env['NEWS_API_KEY'] ?? '';
  }
}
