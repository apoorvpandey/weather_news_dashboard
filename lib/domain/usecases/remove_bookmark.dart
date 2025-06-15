import '../entities/news_article.dart';
import '../repositories/news_repository.dart';

class RemoveBookmark {
  final NewsRepository repository;

  RemoveBookmark(this.repository);

  Future<void> call(NewsArticle article) {
    return repository.removeBookmark(article);
  }
}
