import '../../data/datasources/local/news_local_datasource.dart';
import '../../data/datasources/remote/news_remote_datasource.dart';
import '../../data/model/news_article_model.dart';
import '../../domain/entities/news_article.dart';
import '../../domain/repositories/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource remote;
  final NewsLocalDataSource local;

  NewsRepositoryImpl(this.remote, this.local);

  NewsArticle _mapModelToEntity(NewsArticleModel model) => NewsArticle(
    title: model.title,
    description: model.description,
    url: model.url,
    urlToImage: model.urlToImage,
    publishedAt: model.publishedAt,
    sourceName: model.sourceName,
    content: model.content,
  );

  @override
  Future<List<NewsArticle>> getTopHeadlines({String category = ''}) async {
    final articles = await remote.getTopHeadlines(category: category);
    return articles.map(_mapModelToEntity).toList();
  }

  @override
  Future<List<NewsArticle>> searchArticles(String query) async {
    final articles = await remote.searchArticles(query);
    return articles.map(_mapModelToEntity).toList();
  }

  @override
  Future<void> bookmarkArticle(NewsArticle article) async {
    await local.bookmarkArticle(
      NewsArticleModel(
        title: article.title,
        description: article.description,
        url: article.url,
        urlToImage: article.urlToImage,
        publishedAt: article.publishedAt,
        sourceName: article.sourceName,
        content: article.content,
      ),
    );
  }

  @override
  Future<void> removeBookmark(NewsArticle article) async {
    await local.removeBookmark(article.url);
  }

  @override
  Future<List<NewsArticle>> getBookmarks() async {
    final articles = await local.getBookmarks();
    return articles.map(_mapModelToEntity).toList();
  }
}
