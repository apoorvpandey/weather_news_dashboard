import 'dart:async';

import 'package:flutter/material.dart';

import '../../../domain/entities/news_article.dart';
import '../../../domain/usecases/bookmark_article.dart';
import '../../../domain/usecases/get_bookmarks.dart';
import '../../../domain/usecases/get_top_headlines.dart';
import '../../../domain/usecases/remove_bookmark.dart';
import '../../../domain/usecases/search_news_articles.dart';

enum NewsState { initial, loading, loaded, error }

class NewsProvider extends ChangeNotifier {
  final GetTopHeadlines getTopHeadlines;
  final SearchNewsArticles searchArticles;
  final BookmarkArticle bookmarkArticle;
  final RemoveBookmark removeBookmark;
  final GetBookmarks getBookmarks;

  NewsProvider({
    required this.getTopHeadlines,
    required this.searchArticles,
    required this.bookmarkArticle,
    required this.removeBookmark,
    required this.getBookmarks,
  });

  NewsState _state = NewsState.initial;

  NewsState get state => _state;

  List<NewsArticle> _articles = [];

  List<NewsArticle> get articles => _articles;

  String? _error;

  String? get error => _error;

  // For bookmarks
  List<NewsArticle> _bookmarks = [];

  List<NewsArticle> get bookmarks => _bookmarks;

  // For search
  Timer? _debounce;

  String _currentCategory = 'general';

  String get currentCategory => _currentCategory;

  Future<void> fetchTopHeadlines({String category = 'general'}) async {
    _state = NewsState.loading;
    _error = null;
    notifyListeners();

    try {
      _currentCategory = category;
      _articles = await getTopHeadlines(category: category);
      _state = NewsState.loaded;
    } catch (e) {
      _error = e.toString();
      _state = NewsState.error;
    }
    notifyListeners();
  }

  void search(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 700), () async {
      if (query.isEmpty) {
        fetchTopHeadlines(category: _currentCategory);
        return;
      }
      _state = NewsState.loading;
      notifyListeners();
      try {
        _articles = await searchArticles(query);
        _state = NewsState.loaded;
      } catch (e) {
        _error = e.toString();
        _state = NewsState.error;
      }
      notifyListeners();
    });
  }

  Future<void> addBookmark(NewsArticle article) async {
    await bookmarkArticle(article);
    await loadBookmarks();
    notifyListeners();
  }

  Future<void> removeBookmarkArticle(NewsArticle article) async {
    await removeBookmark(article);
    await loadBookmarks();
    notifyListeners();
  }

  Future<void> loadBookmarks() async {
    _bookmarks = await getBookmarks();
    notifyListeners();
  }
}
