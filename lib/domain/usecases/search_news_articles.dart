import '../entities/news_article.dart';
import '../repositories/news_repository.dart';

class SearchNewsArticles {
  final NewsRepository repository;

  SearchNewsArticles(this.repository);

  Future<List<NewsArticle>> call(String query) {
    return repository.searchArticles(query);
  }
}
