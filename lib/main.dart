import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:newsapp/presentation/screens/news_list_screen.dart';
import 'package:newsapp/presentation/stores/theme_store.dart';
import 'package:newsapp/presentation/stores/news_list_store.dart';
import 'package:newsapp/data/repositories/secure_key_repository.dart';
import 'package:newsapp/di/service_locator.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:newsapp/core/constants/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator(); // Initialize service locator

  // Save the API key during app initialization
  final secureKeyRepository = serviceLocator<SecureKeyRepository>();
  await secureKeyRepository.saveApiKey('your-secret-api-key');

  final themeStore = ThemeStore(); // Create ThemeStore to load saved theme
  await themeStore.initializeTheme(); // Initialize theme properly
  runApp(MyApp(themeStore: themeStore));
}

class MyApp extends StatelessWidget {
  final ThemeStore themeStore;

  MyApp({required this.themeStore});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ThemeStore>(create: (_) => themeStore),
        Provider<NewsListStore>(create: (_) => serviceLocator<NewsListStore>()),
      ],
      child: Observer(
        builder: (_) => MaterialApp(
          title: 'NewsApp',
          themeMode: themeStore.themeMode, // Use MobX for dynamic theme switching
          theme: lightTheme,
          darkTheme: darkTheme,
          home: NewsListScreen(),
        ),
      ),
    );
  }
}
