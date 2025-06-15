import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../../domain/entities/news_article.dart';

class NewsArticleTile extends StatelessWidget {
  final NewsArticle article;
  final VoidCallback onBookmark;
  final VoidCallback onShare;

  const NewsArticleTile({
    required this.article,
    required this.onBookmark,
    required this.onShare,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _NewsImage(url: article.urlToImage),
            const SizedBox(width: 12),
            // --- Title, Source, Actions ---
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    article.sourceName,
                    style: TextStyle(color: Colors.grey[700], fontSize: 13),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.bookmark_add_outlined, size: 22),
                        onPressed: onBookmark,
                        tooltip: 'Bookmark',
                      ),
                      IconButton(
                        icon: const Icon(Icons.share, size: 22),
                        onPressed: () =>
                            Share.share('${article.title}\n${article.url}'),
                        tooltip: 'Share',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NewsImage extends StatelessWidget {
  final String url;

  const _NewsImage({required this.url});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: url.isNotEmpty
          ? Image.network(
              url,
              width: 70,
              height: 70,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: Colors.grey[200],
                width: 70,
                height: 70,
                child: const Icon(
                  Icons.broken_image,
                  size: 30,
                  color: Colors.grey,
                ),
              ),
            )
          : Container(
              color: Colors.grey[200],
              width: 70,
              height: 70,
              child: const Icon(Icons.article, size: 30, color: Colors.grey),
            ),
    );
  }
}
