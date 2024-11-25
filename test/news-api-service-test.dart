import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';
import 'package:newsapp/data/models/article.dart';
import 'package:newsapp/core/constants/api_constants.dart';
import 'package:newsapp/data/services/news_api_service.dart';
import 'mocks.mocks.dart';

void main() {
  late NewsApiService newsApiService;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    newsApiService = NewsApiService(mockDio);
  });

  const mockResponseData = {
    'articles': [
      {
        'source': {
          'id': 'techcrunch',
          'name': 'TechCrunch',
        },
        'author': 'John Doe',
        'title': 'Sample Title',
        'description': 'Sample Description',
        'url': 'https://example.com',
        'urlToImage': 'https://example.com/image.jpg',
        'publishedAt': '2024-11-25T12:00:00Z',
        'content': 'Sample content of the article.',
      },
    ],
  };

  group('fetchTopHeadlines', () {
    test('returns a list of articles when the API call succeeds', () async {
      // Arrange

      when(mockDio.get(
        'https://newsapi.org/v2/top-headlines',
        queryParameters: {
          'country': 'us',
          'apiKey': apiKey,
        },
      )).thenAnswer((_) async => Response(
            data: mockResponseData,
            statusCode: 200,
            requestOptions: RequestOptions(path: ''),
          ));

      // Act
      final articles = await newsApiService.fetchTopHeadlines();

      // Assert
      expect(articles, isA<List<Article>>());
      expect(articles.length, 1);
      expect(articles.first.title, 'Sample Title');
      expect(articles.first.source.name, 'TechCrunch');
    });
    test('throws an exception when the API call fails', () async {
      // Arrange
      when(mockDio.get(
        'https://newsapi.org/v2/top-headlines',
        queryParameters: {
          'country': 'us',
          'apiKey': apiKey,
        },
      )).thenAnswer((_) async => Response(
            statusCode: 500,
            requestOptions: RequestOptions(path: ''),
          ));

      // Act & Assert
      expect(
        newsApiService.fetchTopHeadlines(),
        throwsA(isA<Exception>()),
      );
    });
  });

  group('fetchArticlesByTopic', () {
    test('returns a list of articles when the API call succeeds', () async {
      // Arrange
      const mockResponseData = {
        'articles': [
          {
            'source': {
              'id': 'techcrunch',
              'name': 'TechCrunch',
            },
            'author': 'Jane Doe',
            'publishedAt': '2024-11-25T13:00:00Z',
            'title': 'Tech News Title',
            'description': 'Tech News Description',
            'url': 'https://example.com',
            'urlToImage': 'https://example.com/image.jpg',
            'content': 'Sample content of the article.',
          },
        ],
      };


      when(mockDio.get(
        'https://newsapi.org/v2/everything',
        queryParameters: {
          'q': 'tech',
          'apiKey': apiKey,
        },
      )).thenAnswer((_) async => Response(
            data: mockResponseData,
            statusCode: 200,
            requestOptions: RequestOptions(path: ''),
          ));

      // Act
      final articles = await newsApiService.fetchArticlesByTopic('tech');

      // Assert
      expect(articles, isA<List<Article>>());
      expect(articles.length, 1);
      expect(articles.first.title, 'Tech News Title');
    });

    test('throws an exception when the API call fails', () async {
      // Arrange
      when(mockDio.get(
        'https://newsapi.org/v2/everything',
        queryParameters: {
          'q': 'tech',
          'apiKey': apiKey,
        },
      )).thenAnswer((_) async => Response(
            statusCode: 404,
            requestOptions: RequestOptions(path: ''),
          ));

      // Act & Assert
      expect(
        newsApiService.fetchArticlesByTopic('tech'),
        throwsA(isA<Exception>()),
      );
    });
  });

  group('searchArticles', () {
    test('returns a list of articles when the API call succeeds', () async {
      // Arrange
      const mockResponseData = {
        'articles': [
          {
            'source': {
              'id': 'techcrunch',
              'name': 'TechCrunch',
            },
            'title': 'Search Result Title',
            'description': 'Search Result Description',
            'author': 'Sam Smith',
            'publishedAt': '2024-11-25T14:00:00Z',
            'url': 'https://example.com',
            'urlToImage': 'https://example.com/image.jpg',
            'content': 'Sample content of the article.',
          },
        ],
      };

      when(mockDio.get(
        'https://newsapi.org/v2/everything',
        queryParameters: {
          'q': 'flutter',
          'apiKey': apiKey,
        },
      )).thenAnswer((_) async => Response(
            data: mockResponseData,
            statusCode: 200,
            requestOptions: RequestOptions(path: ''),
          ));

      // Act
      final articles = await newsApiService.searchArticles('flutter');

      // Assert
      expect(articles, isA<List<Article>>());
      expect(articles.length, 1);
      expect(articles.first.title, 'Search Result Title');
    });

    test('throws an exception when the API call fails', () async {
      // Arrange
      when(mockDio.get(
        'https://newsapi.org/v2/everything',
        queryParameters: {
          'q': 'flutter',
          'apiKey': apiKey,
        },
      )).thenAnswer((_) async => Response(
            statusCode: 403,
            requestOptions: RequestOptions(path: ''),
          ));

      // Act & Assert
      expect(
        newsApiService.searchArticles('flutter'),
        throwsA(isA<Exception>()),
      );
    });
  });
}
