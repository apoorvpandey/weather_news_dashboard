import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../data/datasources/local/news_local_datasource.dart';
import '../../data/datasources/remote/news_remote_datasource.dart';
import '../../data/datasources/remote/weather_remote_datasource.dart';
import '../../domain/repositories/news_repository_impl.dart';
import '../../domain/repositories/weather_repository_impl.dart';
import '../../domain/usecases/bookmark_article.dart';
import '../../domain/usecases/get_bookmarks.dart';
import '../../domain/usecases/get_current_weather.dart';
import '../../domain/usecases/get_forecast.dart';
import '../../domain/usecases/get_top_headlines.dart';
import '../../domain/usecases/remove_bookmark.dart';
import '../../domain/usecases/search_news_articles.dart';
import '../../presentation/providers/news_provider/news_provider.dart';
import '../../presentation/providers/theme_provider/theme_provider.dart';
import '../../presentation/providers/weather_provider/weather_provider.dart';

List<SingleChildWidget> appProviders() {
  final dio = Dio();
  final weatherRemoteDataSource = WeatherRemoteDataSource(dio);
  final weatherRepository = WeatherRepositoryImpl(weatherRemoteDataSource);
  final getCurrentWeather = GetCurrentWeather(weatherRepository);
  final getForecast = GetForecast(weatherRepository);

  final newsRemote = NewsRemoteDataSource(Dio());
  final newsLocal = NewsLocalDataSource();
  final newsRepo = NewsRepositoryImpl(newsRemote, newsLocal);
  final getTopHeadlines = GetTopHeadlines(newsRepo);
  final searchNewsArticles = SearchNewsArticles(newsRepo);
  final bookmarkArticle = BookmarkArticle(newsRepo);
  final removeBookmark = RemoveBookmark(newsRepo);
  final getBookmarks = GetBookmarks(newsRepo);

  return [
    ChangeNotifierProvider(
      create: (_) => WeatherProvider(getCurrentWeather, getForecast),
    ),
    ChangeNotifierProvider(
      create: (_) => NewsProvider(
        getTopHeadlines: getTopHeadlines,
        searchArticles: searchNewsArticles,
        bookmarkArticle: bookmarkArticle,
        removeBookmark: removeBookmark,
        getBookmarks: getBookmarks,
      ),
    ),
    ChangeNotifierProvider(create: (_) => ThemeProvider()),
  ];
}
