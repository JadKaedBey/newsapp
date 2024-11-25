import 'package:dio/dio.dart';
import 'package:newsapp/core/constants/api_constants.dart';
import 'package:newsapp/data/models/article.dart';

class NewsApiService {
  final Dio dio;

  NewsApiService(this.dio);

  Future<List<Article>> fetchTopHeadlines() async {
    final response = await dio.get(
      'https://newsapi.org/v2/top-headlines',
      queryParameters: {
        'country': 'us',
        'apiKey': apiKey,
      },
    );

    if (response.statusCode == 200) {
      final data = response.data['articles'] as List;
      return data.map((article) => Article.fromJson(article)).toList();
    } else {
      throw Exception('Failed to fetch top headlines');
    }
  }

  Future<List<Article>> fetchArticlesByTopic(String topic) async {
    final response = await dio.get(
      'https://newsapi.org/v2/everything',
      queryParameters: {
        'q': topic,
        'apiKey': apiKey,
      },
    );

    if (response.statusCode == 200) {
      final data = response.data['articles'] as List;
      return data.map((article) => Article.fromJson(article)).toList();
    } else {
      throw Exception('Failed to fetch articles for topic: $topic');
    }
  }

  Future<List<Article>> searchArticles(String query) async {
    final response = await dio.get(
      'https://newsapi.org/v2/everything',
      queryParameters: {
        'q': query,
        'apiKey': apiKey,
      },
    );

    if (response.statusCode == 200) {
      final data = response.data['articles'] as List;
      return data.map((article) => Article.fromJson(article)).toList();
    } else {
      throw Exception('Failed to fetch search results for: $query');
    }
  }
}

