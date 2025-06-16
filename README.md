# Weather & News Dashboard

A modern Flutter application built with Clean Architecture (SOLID), Provider, Hive (offline bookmarks), and flutter_dotenv for secure API keys.  
**SDK:** Flutter 3.32.4 (managed with FVM)

---

## 🚀 Features

- **Weather Dashboard:**
    - Search weather by city or current location
    - 5-day forecast
- **News Headlines:**
    - Category filter (General, Business, Technology, Sports)
    - Debounced search
    - Offline bookmarks (Hive)
    - Article sharing
- **Tabbed interface:** Weather & News (single dashboard)
- **Provider** for scalable state management
- **.env** for API keys (never hardcoded)
- **FVM** for consistent SDK version

---

## 🛠️ Getting Started

### Prerequisites

- [FVM](https://fvm.app/) (Flutter Version Manager)
- Flutter SDK **3.32.4**

### Clone the repository

```sh
git clone <your-repo-url>
cd weather_news_dashboard
```

### Install Flutter SDK using FVM

```sh
fvm install 3.32.4
fvm use 3.32.4
```

### Install dependencies

```sh
fvm flutter pub get
```

### Set up API keys

Create a `.env` file at the root:

```
OPEN_WEATHER_API_KEY=your_openweathermap_api_key
NEWS_API_KEY=your_newsapi_api_key
```
Get keys at [OpenWeather](https://openweathermap.org/api) and [NewsAPI](https://newsapi.org/)

### Run the app

```sh
fvm flutter run
```

---

## 📁 Project Structure

```
lib/
  core/
    config/          # AppEnvironment, providers, .env setup
  data/
    datasources/     # Weather/news remote & local data
    models/          # DTOs for weather/news
    repositories/    # Data-layer implementations
  domain/
    entities/        # Core models (Weather, NewsArticle)
    repositories/    # Abstract repository contracts
    usecases/        # Business logic
  presentation/
    pages/           # UI screens: weather, news, dashboard
    providers/       # State management (Provider)
    widgets/         # UI widgets
```

---

## ✨ Notable Packages

- [provider](https://pub.dev/packages/provider)
- [dio](https://pub.dev/packages/dio)
- [hive](https://pub.dev/packages/hive), [hive_flutter](https://pub.dev/packages/hive_flutter)
- [flutter_dotenv](https://pub.dev/packages/flutter_dotenv)
- [geolocator](https://pub.dev/packages/geolocator)
- [share_plus](https://pub.dev/packages/share_plus)

---

## 🧑‍💻 Usage

- **Weather Tab:**  
  Enter a city or tap the location icon for live weather and a 5-day forecast.
- **News Tab:**  
  Filter by category, search for news, bookmark articles for offline reading, and share with friends.

---

## 🙌 Credits

- Weather: [OpenWeather](https://openweathermap.org/)
- News: [NewsAPI.org](https://newsapi.org/)
- Icons: [Material Icons](https://fonts.google.com/icons)

---

> Built with ❤️ using Flutter 3.32.4 (FVM), Provider, Hive, and Clean Architecture.