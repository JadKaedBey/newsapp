import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:newsapp/presentation/screens/news_details_screen.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:newsapp/data/models/article.dart';
import 'mocks.mocks.dart';

void main() {
  late MockArticle mockArticle;

  setUp(() {
    mockArticle = MockArticle();

    // Mock default values
    when(mockArticle.title).thenReturn('Sample Article Title');
    when(mockArticle.description).thenReturn('Sample Article Description');
    when(mockArticle.author).thenReturn('John Doe');
    when(mockArticle.formattedPublishedAt).thenReturn('2024-11-25');
    when(mockArticle.urlToImage).thenReturn('https://example.com/image.jpg');
    when(mockArticle.url).thenReturn('https://example.com/full-article');
  });

  Widget createTestableWidget(MockArticle article) {
    return MaterialApp(
      home: NewsDetailsScreen(article: article),
    );
  }

  group('NewsDetailsScreen Tests with MockArticle', () {
    testWidgets('Displays article details correctly', (tester) async {
      await tester.pumpWidget(createTestableWidget(mockArticle));

      print('Mocked Title: ${mockArticle.title}');

      final appBarTitleFinder = find.descendant(
        of: find.byType(AppBar),
        matching: find.text('Sample Article Title'),
      );

      // Assert that only one AppBar title exists
      expect(appBarTitleFinder, findsOneWidget,
          reason: 'AppBar title should match the article title.');

      // Assert that only one AppBar title exists
      expect(appBarTitleFinder, findsOneWidget,
          reason: 'AppBar title should match the article title.');
      // Find the body title specifically
      final bodyTitleFinder = find.descendant(
        of: find.byType(SingleChildScrollView),
        matching: find.text('Sample Article Title'),
      );

      // Assert that only one body title exists
      expect(bodyTitleFinder, findsOneWidget,
          reason: 'Body title should match the article title.');

      // Verify description
      expect(find.text('Sample Article Description'), findsOneWidget);
      // Verify author and date
      expect(find.text('By John Doe on 2024-11-25'), findsOneWidget);
    });

    testWidgets('Handles missing title, description, and author gracefully',
        (tester) async {
      when(mockArticle.title).thenReturn(null);
      when(mockArticle.description).thenReturn(null);
      when(mockArticle.author).thenReturn(null);

      await tester.pumpWidget(createTestableWidget(mockArticle));

      // Verify fallback title
      expect(find.text('No Title'),
          findsWidgets); // dindnt use findsOneWidget since also the appbar should contain the title
      // Verify fallback description
      expect(find.text('No Description'), findsOneWidget);
      // Verify fallback author
      expect(find.text('By Unknown on 2024-11-25'), findsOneWidget);
    });

    testWidgets('Displays image if urlToImage is valid', (tester) async {
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(createTestableWidget(mockArticle));

        // Verify that the image is rendered
        expect(find.byType(Image), findsOneWidget);
      });
    });

    testWidgets('Displays placeholder if urlToImage is null', (tester) async {
      when(mockArticle.urlToImage).thenReturn(null);

      await tester.pumpWidget(createTestableWidget(mockArticle));

      // Verify placeholder icon
      expect(find.byIcon(Icons.broken_image), findsOneWidget);
    });

    testWidgets('Read Full Article button opens URL for valid article',
        (tester) async {
      // Arrange
      await tester.pumpWidget(createTestableWidget(mockArticle));

      // Tap the button
      final button = find.byType(ElevatedButton);
      await tester.tap(button);
      await tester.pump();

      // No `launchUrl` mock is set here, but integration testing could cover this.
    });

    // This test fails even though the snackbar does show up on screen. the debugDumpApp does not print any SnackBar. Will come back to this if i find the time.
    testWidgets('Read Full Article button shows a SnackBar for invalid URL',
        (tester) async {
      // Arrange: Mock article with an invalid URL
      when(mockArticle.url).thenReturn('invalid-url');

      // Build the widget wrapped with a Scaffold
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NewsDetailsScreen(article: mockArticle),
          ),
        ),
      );

      // Act: Tap the "Read Full Article" button
      final buttonFinder = find.byType(ElevatedButton);
      await tester.tap(buttonFinder);
      await tester.pumpAndSettle();

      // Debug the widget tree to ensure SnackBar exists
      debugDumpApp();

      // Assert: Verify that a SnackBar is displayed
      final snackBarFinder = find.byType(SnackBar);
      expect(snackBarFinder, findsOneWidget);
    });

    testWidgets('Disables Read Full Article button if url is null',
        (tester) async {
      when(mockArticle.url).thenReturn(null);

      await tester.pumpWidget(createTestableWidget(mockArticle));

      // Verify button is disabled
      final button = find.byType(ElevatedButton);
      expect(tester.widget<ElevatedButton>(button).enabled, isFalse);
    });
  });
}
