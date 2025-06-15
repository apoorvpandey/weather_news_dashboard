import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/news_provider/news_provider.dart';
import '../widgets/book_mark_sheet.dart';
import '../widgets/category_selector.dart';
import '../widgets/news_article_tile.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NewsProvider>(context);

    return ListView(
      padding: const EdgeInsets.all(0),
      children: [
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Tooltip(
              message: "View Bookmarks",
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(24),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (_) => BookmarksSheet(),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Icon(
                      Icons.bookmark,
                      size: 28,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0, left: 16, right: 16),
          child: Text(
            'Top Headlines',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: CategorySelector(
            current: provider.currentCategory,
            onChanged: (cat) => provider.fetchTopHeadlines(category: cat),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: TextField(
            onChanged: provider.search,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search news...',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Builder(
          builder: (_) {
            if (provider.state == NewsState.loading) {
              return const Padding(
                padding: EdgeInsets.only(top: 48.0),
                child: Center(child: CircularProgressIndicator()),
              );
            } else if (provider.state == NewsState.error) {
              return Padding(
                padding: const EdgeInsets.only(top: 48.0),
                child: Center(
                  child: Text(provider.error ?? 'Error loading news'),
                ),
              );
            } else if (provider.articles.isEmpty) {
              return const Padding(
                padding: EdgeInsets.only(top: 48.0),
                child: Center(child: Text('No articles found.')),
              );
            } else {
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: provider.articles.length,
                itemBuilder: (context, index) {
                  final article = provider.articles[index];
                  return NewsArticleTile(
                    article: article,
                    onBookmark: () => provider.addBookmark(article),
                    onShare: () {
                      // onShare
                    },
                  );
                },
              );
            }
          },
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
