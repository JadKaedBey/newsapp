import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart' as mockito;
import 'package:flutter/material.dart';
import 'package:newsapp/presentation/stores/news_list_store.dart';
import 'package:newsapp/presentation/stores/theme_store.dart';
import 'package:newsapp/presentation/screens/news_list_screen.dart';
import 'package:newsapp/presentation/screens/news_details_screen.dart';
import 'package:newsapp/data/models/article.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'mocks.mocks.dart';

void main() {
  late MockNewsListStore mockNewsListStore;
  late MockThemeStore mockThemeStore;

  setUp(() {
    mockNewsListStore = MockNewsListStore();
    mockThemeStore = MockThemeStore();

    // Mock default properties
    mockito.when(mockThemeStore.themeMode).thenReturn(ThemeMode.light);
    mockito.when(mockNewsListStore.isLoading).thenReturn(false);
    mockito.when(mockNewsListStore.errorMessage).thenReturn(null);
    mockito.when(mockNewsListStore.articles).thenReturn(ObservableList());
  });

  Widget createTestableWidget() {
    return MultiProvider(
      providers: [
        Provider<NewsListStore>(create: (_) => mockNewsListStore),
        Provider<ThemeStore>(create: (_) => mockThemeStore),
      ],
      child: MaterialApp(
        home: NewsListScreen(),
      ),
    );
  }

  group('NewsListScreen Tests', () {
    testWidgets('Switching tabs fetches appropriate articles', (tester) async {
      // Arrange
      mockito.when(mockNewsListStore.fetchTopHeadlines()).thenAnswer((_) async {});
      mockito.when(mockNewsListStore.fetchArticlesByTopic('Tech')).thenAnswer((_) async {});

      await tester.pumpWidget(createTestableWidget());
      await tester.pumpAndSettle();

      // Act: Tap on the "Tech" tab
      final techTab = find.text('Tech');
      expect(techTab, findsOneWidget); // Ensure "Tech" tab exists
      await tester.tap(techTab);
      await tester.pumpAndSettle();

      // Assert
      mockito.verify(mockNewsListStore.fetchArticlesByTopic('Tech')).called(1);
    });

    testWidgets('Displays loading indicator when loading', (tester) async {
      // Arrange
      mockito.when(mockNewsListStore.isLoading).thenReturn(true);

      await tester.pumpWidget(createTestableWidget());
      // await tester.pumpAndSettle();

      // Act & Assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

  //   testWidgets('Tapping on article navigates to NewsDetailsScreen', (tester) async {
  //   // Arrange: Mock Article
  //   final article = MockArticle();
  //   mockito.when(article.urlToImage).thenReturn('https://example.com/image.jpg');
  //   mockito.when(article.title).thenReturn('Sample Article Title');
  //   mockito.when(article.description).thenReturn('Sample Article Description');
  //   mockito.when(mockNewsListStore.articles).thenReturn(ObservableList.of([article]));

  //   // Act & Assert: Mock Image.network
  //   await mockNetworkImagesFor(() async {
  //     await tester.pumpWidget(createTestableWidget());

  //     // Verify article tile exists
  //     final articleTile = find.text('Sample Article Title');
  //     expect(articleTile, findsOneWidget);

  //     // Tap the article tile
  //     await tester.tap(articleTile);
  //     await tester.pumpAndSettle();

  //     // Verify navigation to NewsDetailsScreen
  //     expect(find.byType(NewsDetailsScreen), findsOneWidget);
  //   });
  // });

    testWidgets('Theme toggle switches theme and refreshes articles', (tester) async {
      // Arrange
      mockito.when(mockThemeStore.themeMode).thenReturn(ThemeMode.light);
      mockito.when(mockNewsListStore.fetchTopHeadlines()).thenAnswer((_) async {});

      await tester.pumpWidget(createTestableWidget());

      // Act: Toggle theme switch
      final themeSwitch = find.byType(Switch);
      await tester.tap(themeSwitch);
      await tester.pumpAndSettle();

      // Assert
      mockito.verify(mockThemeStore.toggleTheme(ThemeMode.dark)).called(1);
    });
  });
}


