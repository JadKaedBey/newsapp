import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:newsapp/data/models/article.dart';
import 'package:newsapp/presentation/stores/news_list_store.dart';
import 'package:newsapp/presentation/stores/theme_store.dart';

@GenerateMocks([NewsListStore, ThemeStore, Article, Dio])
void main() {}
