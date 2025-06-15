import '../entities/news_article.dart';
import '../repositories/news_repository.dart';

class GetBookmarks {
  final NewsRepository repository;

  GetBookmarks(this.repository);

  Future<List<NewsArticle>> call() {
    return repository.getBookmarks();
  }
}
