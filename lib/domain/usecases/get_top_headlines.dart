import '../entities/news_article.dart';
import '../repositories/news_repository.dart';

class GetTopHeadlines {
  final NewsRepository repository;

  GetTopHeadlines(this.repository);

  Future<List<NewsArticle>> call({String category = ''}) {
    return repository.getTopHeadlines(category: category);
  }
}
