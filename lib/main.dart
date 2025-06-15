import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:weather_news_dashboard/presentation/pages/weather_page.dart';

import 'core/config/app_environment.dart';
import 'core/config/app_providers.dart';

void main() async {
  await dotenv.load();
  await Hive.initFlutter();
  AppEnvironment.setupEnv();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: appProviders(),
      child: MaterialApp(
        title: 'Weather News Dashboard',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: false),
        home: const WeatherPage(),
      ),
    );
  }
}
