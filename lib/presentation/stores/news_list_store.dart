import 'package:mobx/mobx.dart';
import 'package:newsapp/data/models/article.dart';
import 'package:newsapp/data/repositories/news_repository.dart';

part 'news_list_store.g.dart';

class NewsListStore = _NewsListStore with _$NewsListStore;

abstract class _NewsListStore with Store {
  final NewsRepository repository;

  _NewsListStore(this.repository);

  @observable
  ObservableList<Article> articles = ObservableList<Article>();

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @observable
  String selectedTopic = "Home"; // Default to Home (Top Headlines)

  @action
  Future<void> fetchTopHeadlines() async {
    isLoading = true;
    errorMessage = null;

    try {
      final fetchedArticles = await repository.getTopHeadlines();
      articles.clear();
      articles.addAll(fetchedArticles);
      selectedTopic = "Home";
    } catch (e) {
      errorMessage = 'Failed to fetch top headlines';
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> fetchArticlesByTopic(String topic) async {
    isLoading = true;
    errorMessage = null;

    try {
      final fetchedArticles = await repository.getArticlesByTopic(topic);
      articles.clear();
      articles.addAll(fetchedArticles);
      selectedTopic = topic;
    } catch (e) {
      errorMessage = 'Failed to fetch articles for topic: $topic';
    } finally {
      isLoading = false;
    }
  }

  // @action
  // Future<void> searchArticles(String query) async {
  //   isLoading = true;
  //   errorMessage = null;

  //   try {
  //     final fetchedArticles = await repository.searchArticles(query);
  //     articles.clear();
  //     articles.addAll(fetchedArticles);
  //   } catch (e) {
  //     errorMessage = 'Failed to fetch search results for: $query';
  //   } finally {
  //     isLoading = false;
  //   }
  // }
}
