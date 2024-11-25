import 'package:newsapp/data/models/article.dart';
import 'package:newsapp/data/repositories/news_repository.dart';

class FetchTopHeadlines {
  final NewsRepository repository;

  FetchTopHeadlines(this.repository);

  Future<List<Article>> call() => repository.getTopHeadlines();
}
