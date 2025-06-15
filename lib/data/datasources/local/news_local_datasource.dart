import 'package:hive/hive.dart';

import '../../model/news_article_model.dart';

class NewsLocalDataSource {
  static const String _boxName = 'bookmarks';

  Future<void> bookmarkArticle(NewsArticleModel article) async {
    final box = await Hive.openBox<NewsArticleModel>(_boxName);
    await box.put(article.url, article); // Use url as key
  }

  Future<void> removeBookmark(String url) async {
    final box = await Hive.openBox<NewsArticleModel>(_boxName);
    await box.delete(url);
  }

  Future<List<NewsArticleModel>> getBookmarks() async {
    final box = await Hive.openBox<NewsArticleModel>(_boxName);
    return box.values.toList();
  }
}