// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_list_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$NewsListStore on _NewsListStore, Store {
  late final _$articlesAtom =
      Atom(name: '_NewsListStore.articles', context: context);

  @override
  ObservableList<Article> get articles {
    _$articlesAtom.reportRead();
    return super.articles;
  }

  @override
  set articles(ObservableList<Article> value) {
    _$articlesAtom.reportWrite(value, super.articles, () {
      super.articles = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_NewsListStore.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_NewsListStore.errorMessage', context: context);

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$selectedTopicAtom =
      Atom(name: '_NewsListStore.selectedTopic', context: context);

  @override
  String get selectedTopic {
    _$selectedTopicAtom.reportRead();
    return super.selectedTopic;
  }

  @override
  set selectedTopic(String value) {
    _$selectedTopicAtom.reportWrite(value, super.selectedTopic, () {
      super.selectedTopic = value;
    });
  }

  late final _$fetchTopHeadlinesAsyncAction =
      AsyncAction('_NewsListStore.fetchTopHeadlines', context: context);

  @override
  Future<void> fetchTopHeadlines() {
    return _$fetchTopHeadlinesAsyncAction.run(() => super.fetchTopHeadlines());
  }

  late final _$fetchArticlesByTopicAsyncAction =
      AsyncAction('_NewsListStore.fetchArticlesByTopic', context: context);

  @override
  Future<void> fetchArticlesByTopic(String topic) {
    return _$fetchArticlesByTopicAsyncAction
        .run(() => super.fetchArticlesByTopic(topic));
  }

  @override
  String toString() {
    return '''
articles: ${articles},
isLoading: ${isLoading},
errorMessage: ${errorMessage},
selectedTopic: ${selectedTopic}
    ''';
  }
}
