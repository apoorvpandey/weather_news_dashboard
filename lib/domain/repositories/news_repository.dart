import '../entities/news_article.dart';

abstract class NewsRepository {
  Future<List<NewsArticle>> getTopHeadlines({String category});

  Future<List<NewsArticle>> searchArticles(String query);

  Future<void> bookmarkArticle(NewsArticle article);

  Future<void> removeBookmark(NewsArticle article);

  Future<List<NewsArticle>> getBookmarks();
}
