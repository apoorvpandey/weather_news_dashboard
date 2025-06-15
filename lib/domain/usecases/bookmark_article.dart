import '../entities/news_article.dart';
import '../repositories/news_repository.dart';

class BookmarkArticle {
  final NewsRepository repository;

  BookmarkArticle(this.repository);

  Future<void> call(NewsArticle article) {
    return repository.bookmarkArticle(article);
  }
}
