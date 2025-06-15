import 'package:dio/dio.dart';

import '../../../../core/config/app_environment.dart';
import '../../model/news_article_model.dart';

class NewsRemoteDataSource {
  final Dio dio;

  NewsRemoteDataSource(this.dio);

  Future<List<NewsArticleModel>> getTopHeadlines({String category = ''}) async {
    final url = 'https://newsapi.org/v2/top-headlines';
    final params = {
      'country': 'in', // INDIA
      'apiKey': AppEnvironment.newsApiKey,
      if (category.isNotEmpty) 'category': category,
      'pageSize': 40,
    };

    final response = await dio.get(url, queryParameters: params);
    final articles = response.data['articles'] as List;
    return articles.map((e) => NewsArticleModel.fromJson(e)).toList();
  }

  Future<List<NewsArticleModel>> searchArticles(String query) async {
    final url = 'https://newsapi.org/v2/everything';
    final params = {
      'q': query,
      'apiKey': AppEnvironment.newsApiKey,
      'pageSize': 40,
    };

    final response = await dio.get(url, queryParameters: params);
    final articles = response.data['articles'] as List;
    return articles.map((e) => NewsArticleModel.fromJson(e)).toList();
  }
}
