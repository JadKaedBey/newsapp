import 'package:flutter/material.dart';
import 'package:newsapp/data/models/article.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailsScreen extends StatelessWidget {
  final Article article;

  NewsDetailsScreen({required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title ?? "No Title"), // Fallback for null title
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Headline Image Section
            article.urlToImage != null
                ? AspectRatio(
                    aspectRatio: 16 / 9, // Maintain a 16:9 aspect ratio
                    child: Image.network(
                      article.urlToImage!,
                      fit: BoxFit.cover, // Resize and crop the image to fit
                      width:
                          double.infinity, // Make it stretch across the screen
                      loadingBuilder: (context, child, progress) {
                        if (progress == null)
                          return child; // Show the image if loaded
                        return const Center(
                          child:
                              CircularProgressIndicator(), // Loading indicator
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: Icon(Icons.broken_image,
                              size: 100), // Placeholder for error
                        );
                      },
                    ),
                  )
                : Container(
                    color: Colors.grey[200],
                    height: 200,
                    width: double.infinity,
                    child: Icon(Icons.broken_image,
                        size: 100), // Placeholder for missing image
                  ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Article Title
                  Text(
                    article.title ?? "No Title",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  // Article Description
                  Text(
                    article.description ??
                        "No Description", // Fallback for null description
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  // Author and Published Date
                  Text(
                    'By ${article.author ?? "Unknown"} on ${article.formattedPublishedAt}',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                  SizedBox(height: 16),
                  // Read Full Article Button
                  ElevatedButton(
                    onPressed: article.url != null
                        ? () async {
                            final uri = Uri.tryParse(article
                                .url!); 
                            if (uri == null ||
                                !(uri.isScheme('http') ||
                                    uri.isScheme('https'))) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Invalid URL')),
                              );
                              return;
                            }
                            if (await canLaunchUrl(uri)) {
                              print("can launch");
                              await launchUrl(uri,
                                  mode: LaunchMode
                                      .externalApplication); // Use external browser
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        'Could not launch the article URL')),
                              );
                            }
                          }
                        : null,
                    child: Text('Read Full Article Online'),
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
