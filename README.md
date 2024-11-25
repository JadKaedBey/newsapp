# newsapp

A Flutter News App ;)

## Project Setup

Follow these steps to set up and run the project:

1. **Clone the Repository**  
   Clone this repository to your local machine:
   ```bash
   git clone https://github.com/JadKaedBey/newsapp.git
   cd newsapp
   ```

2. **Install Dependencies**  
   Install all necessary dependencies:
   ```bash
   flutter pub get
   ```

3. **Set Up API Constants**  
   Create a new file named `api_constants.dart` in the `lib/core/constants/` directory. Add your an API key and base URL to this file:
   ```dart
   const String apiKey = 'YOUR_API_KEY_HERE';
   const String baseUrl = 'https://newsapi.org/v2/';
   ```

4. **Run the App**  
   Start the app on an emulator or physical device:
   ```bash
   flutter run
   ```

## Demo

### Light Theme
Screenshots of the app in **Light Theme**:

<div style="display: flex; flex-wrap: wrap; gap: 10px;">
    <img src="/images/phone-light.png" alt="Light Theme Mobile - Home" width="35%">
    <img src="/images/details-phone-light.png" alt="Light Theme Mobile - Article Details" width="35%">
    <img src="/images/tablet-light.png" alt="Light Theme Tablet - Home" width="35%">
    <img src="/images/details-tablet-light.png" alt="Light Theme Tablet - Article Details" width="35%">
</div>

### Dark Theme
Screenshots of the app in **Dark Theme**:

<div style="display: flex; flex-wrap: wrap; gap: 10px;">
    <img src="/images/phone-dark.png" alt="Dark Theme Mobile - Home" width="35%">
    <img src="/images/details-phone-dark.png" alt="Dark Theme Mobile - Article Details" width="35%">
    <img src="/images/tablet-dark.png" alt="Dark Theme Tablet - Home" width="35%">
    <img src="/images/details-tablet-dark.png" alt="Dark Theme Tablet - Article Details" width="35%">
</div>

### Link Opening Demo
A GIF demonstrating the app's functionality of opening a news link in an external browser:

<div style="display: flex; justify-content: center;">
    <img src="/images/link-demo.gif" alt="Link Opening Demo" width="80%">
</div>

## Features

### News List Screen
- **Dynamic Tabs**: Browse news articles by categories such as Home, Tech, Lifestyle, Politics, and Health.
- **Infinite Scroll**: Load more articles as you scroll down the list.
- **Pull-to-Refresh**: Refresh articles in the current tab by pulling down.
- **Theme Toggle**: Switch between Light and Dark modes with a seamless UI update.
- **Real-Time Updates**: Automatically fetch articles based on the selected category or tab.

### News Details Screen
- **Detailed View**: View the full details of a selected news article, including:
  - Headline image.
  - Title, description, and author information.
  - Published date and time.
- **Read Full Article**: Redirect to the full article in an external browser with a single click.
- **Fallback Mechanisms**: Graceful handling for missing data like images, title, or description.

### General Features
- **State Management**: Powered by MobX for efficient state handling and real-time updates.
- **Dynamic Theming**: Changes to the app's theme are reflected across all screens.
- **Provider Integration**: Dependency injection for managing stores and services.
- **Error Handling**: User-friendly error messages for failed network requests.
- **Offline Fallback**: Displays placeholders for missing images and invalid links.
- **Bad Article Filtering**: The API service automatically cleans fetched articles from any articles that are missing key information, such as a headline

## Testing

The project includes unit and widget tests to ensure functionality and reliability:

### Unit Tests
- **API Integration**:
  - Tests for fetching top headlines, articles by topic, and search results from the News API.
  - Verifies successful API responses return a list of articles.
  - Handles API failures by throwing appropriate exceptions.
- **Mocking Dependencies**:
  - Uses `MockDio` to simulate HTTP requests and test API integration without making real network calls.

### Widget Tests
- **News List Screen**:
  - Verifies switching tabs fetches appropriate articles.
  - Checks the display of a loading indicator while articles are being fetched.
  - Ensures theme toggle switches between Light and Dark modes and refreshes the article list.
- **Navigation**:
  - Simulates tapping on an article to navigate to the `NewsDetailsScreen`.
- **Mocked Stores**:
  - Utilizes `MockNewsListStore` and `MockThemeStore` to simulate app states and interactions.

Run the tests using the following command:

```bash
flutter test
```

## Dependencies

- **flutter**
- **flutter_localizations**
- **dio**: ^5.7.0
- **flutter_mobx**: ^2.2.1+1
- **get_it**: ^8.0.2
- **json_annotation**: ^4.9.0
- **url_launcher**: ^6.3.1
- **mobx**: ^2.1.1
- **provider**: ^6.0.0
- **shared_preferences**: ^2.2.3
- **flutter_secure_storage**: ^8.0.0

### Dev Dependencies

- **mockito**: ^5.4.4
- **build_runner**: ^2.3.3
- **mobx_codegen**: ^2.1.1
- **json_serializable**: ^6.8.0
- **flutter_test**
- **network_image_mock**: ^2.0.1
- **flutter_lints**: ^3.0.0