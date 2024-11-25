import 'package:newsapp/data/models/article.dart';
import 'package:newsapp/data/services/news_api_service.dart';

class NewsRepository {
  final NewsApiService apiService;

  NewsRepository(this.apiService);

  Future<List<Article>> getTopHeadlines() async {
    return await apiService.fetchTopHeadlines();
  }

  Future<List<Article>> getArticlesByTopic(String topic) async {
    return await apiService.fetchArticlesByTopic(topic);
  }

  Future<List<Article>> searchArticles(String query) async {
    return await apiService.searchArticles(query);
  }
}
