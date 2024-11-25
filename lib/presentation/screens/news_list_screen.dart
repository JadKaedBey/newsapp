import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:newsapp/presentation/stores/news_list_store.dart';
import 'package:newsapp/presentation/screens/news_details_screen.dart';
import 'package:provider/provider.dart';
import 'package:newsapp/presentation/stores/theme_store.dart';

class NewsListScreen extends StatefulWidget {
  @override
  _NewsListScreenState createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Topics for tabs
  final List<String> topics = [
    "Home",
    "Tech",
    "Lifestyle",
    "Politics",
    "Health"
  ];

  String getCurrentTopic() {
    return topics[_tabController.index];
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: topics.length, vsync: this);

    // Fetch Top Headlines by default
    final newsListStore = context.read<NewsListStore>();
    newsListStore.fetchTopHeadlines();

    void _handleTabChange() {
      final newsListStore = context.read<NewsListStore>();
      final currentTopic = getCurrentTopic();

      debugPrint("Tab changed to: $currentTopic");

      if (currentTopic == "Home") {
        newsListStore.fetchTopHeadlines();
      } else {
        newsListStore.fetchArticlesByTopic(currentTopic);
      }
    }

    // Add a listener to detect tab changes (swipe or tap)
    // Could be enhanced, for now it only refreshes when the animation ends (user has switched to next page)
    // TODO: Implement DefaultTabControllerListener to make use of the animation property 
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        _handleTabChange();
      }
    });

    void updateTopicAndRefresh(String newTopic) {
      final newsListStore = context.read<NewsListStore>();

      if (topics.contains(newTopic)) {
        final newIndex = topics.indexOf(newTopic);
        _tabController.animateTo(newIndex); // Change the tab
        if (newTopic == "Home") {
          newsListStore.fetchTopHeadlines();
        } else {
          newsListStore.fetchArticlesByTopic(newTopic);
        }
      } else {
        debugPrint("Invalid topic: $newTopic");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final newsListStore = context.read<NewsListStore>();
    final themeStore = context.read<ThemeStore>();

    return Observer(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: Text('NewsApp'),
            actions: [
              // Theme Switch Button
              // I know is not a "best practice" to allow the user to make theme changes directly, the better solution would be to just read the user system theme.
              // However, i have chosen to implement this here to showcase the use of the mobx as well as theme management :)
              Row(
                children: [
                  Text(
                    themeStore.themeMode == ThemeMode.light ? "Light" : "Dark",
                    style: TextStyle(fontSize: 16),
                  ),
                  Switch(
                      value: themeStore.themeMode == ThemeMode.dark,
                      onChanged: (value) async {
                        themeStore.toggleTheme(
                            value ? ThemeMode.dark : ThemeMode.light);
                        // Below is a very ugly method i am using to refresh the ui. Since the observer is already integrated, the UI should automatically change
                        // when the themeValue changes. And it does! However the container color for the articles already present on screen does not change, a simple scroll down
                        // causes it to change. This "cheat" has been implemented to save me some time, i might get back to it later :)
                        String currentTopic = getCurrentTopic();
                        if (currentTopic == "Home") {
                          await newsListStore.fetchTopHeadlines();
                        } else {
                          await newsListStore
                              .fetchArticlesByTopic(currentTopic);
                        }
                      }),
                ],
              ),
            ],
            bottom: TabBar(
              controller: _tabController,
              isScrollable: false,
              indicatorColor: Colors.blue,
              indicatorWeight: 4.0,
              labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              unselectedLabelStyle: TextStyle(fontSize: 16),
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.grey,
              tabs: topics.map((topic) => Tab(text: topic)).toList(),
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: topics.map((topic) {
              return Observer(
                builder: (_) {
                  if (newsListStore.isLoading) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (newsListStore.errorMessage != null) {
                    return Center(child: Text(newsListStore.errorMessage!));
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      if (topic == "Home") {
                        await newsListStore.fetchTopHeadlines();
                      } else {
                        await newsListStore.fetchArticlesByTopic(topic);
                      }
                    },
                    child: ListView.builder(
                      itemCount: newsListStore.articles.length,
                      itemBuilder: (context, index) {
                        final article = newsListStore.articles[index];
                        final double imageWidth =
                            MediaQuery.of(context).size.width * 0.4;

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    NewsDetailsScreen(article: article),
                              ),
                            );
                          },
                          child: Observer(
                            builder: (_) => Container(
                              margin: EdgeInsets.all(8),
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .cardColor, // Dynamically fetch theme color
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  // Image Section
                                  Container(
                                    width: imageWidth,
                                    height: imageWidth *
                                        0.75, // Maintain 4:3 aspect ratio
                                    child: article.urlToImage != null
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Image.network(
                                              article.urlToImage!,
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                        : Icon(Icons.broken_image,
                                            size: imageWidth * 0.5),
                                  ),
                                  SizedBox(width: 12),
                                  // Text Section
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          article.title ?? "No Title",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          article.description ??
                                              "No Description",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[600],
                                          ),
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          article.formattedPublishedAt,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[500],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
