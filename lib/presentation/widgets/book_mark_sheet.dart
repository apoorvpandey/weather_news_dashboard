import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/news_provider/news_provider.dart';

class BookmarksSheet extends StatelessWidget {
  const BookmarksSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NewsProvider>(context);
    return FutureBuilder(
      future: provider.loadBookmarks(),
      builder: (context, snapshot) {
        final bookmarks = provider.bookmarks;
        if (bookmarks.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('No bookmarks.'),
            ),
          );
        }
        return ListView.builder(
          itemCount: bookmarks.length,
          itemBuilder: (context, index) {
            final article = bookmarks[index];
            return ListTile(
              title: Text(article.title),
              subtitle: Text(article.sourceName),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => provider.removeBookmarkArticle(article),
              ),
              onTap: () {
                // open in browser or in-app
              },
            );
          },
        );
      },
    );
  }
}
