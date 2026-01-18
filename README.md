# Ditonton - Movie & TV Series App

![Build Status](https://img.shields.io/badge/Build-Passing-brightgreen)
![Coverage](https://img.shields.io/badge/Coverage-95%25-brightgreen)
![Flutter](https://img.shields.io/badge/Flutter-3.38.6-blue)

**Ditonton** is a movie and TV series catalogue application developed as a submission project for the **Become a Flutter Developer Expert** class at [Dicoding Indonesia](https://www.dicoding.com/).

This application implements **Clean Architecture**, **SOLID Principles**, and **Test-Driven Development (TDD)** to ensure the code is clean, structured, and maintainable.

## Key Features

The application includes comprehensive features for both Movies and TV Series:

### Movies
* **Now Playing**: Displays movies currently showing in theaters.
* **Popular**: List of currently popular movies.
* **Top Rated**: List of movies with the highest ratings.
* **Movie Detail**: Detailed movie information, posters, and related recommendations.
* **Search**: Search for movies by title.
* **Watchlist**: Save favorite movies to local storage.

### TV Series
* **Airing Today**: Displays TV series airing today.
* **Popular**: List of popular TV series.
* **Top Rated**: List of TV series with the highest ratings.
* **Series Detail**: Detailed information, seasons, episodes, and recommendations.
* **Search**: Search for TV series.
* **Watchlist**: Save favorite TV series.
* **Season & Episode**: Displays detailed Season and Episode information for TV Series.

## Tech Stack & Libraries

This project is built using the following technologies and libraries:

* **Flutter SDK**: Main UI Framework.
* **Dart**: Programming language.
* **State Management**: `Bloc`.
* **Architecture**: Clean Architecture (Presentation, Domain, Data).
* **Network**: `http` for API requests.
* **Local Storage**: `sqflite` for watchlist caching.
* **Testing**: `mockito`, `bloc_test` for Unit & Widget Testing.
* **Dependency Injection**: `get_it`.
* **Functional Programming**: `dartz` for handling *Either* types.
* **API Source**: [The Movie DB](https://www.themoviedb.org/documentation/api).

## Setup Environment & Security

This application uses `envied` for API Key management to enhance security. Before running the application:

1.  Create an `.env` file in the project root (at the same level as `pubspec.yaml`).
2.  Populate the `.env` file with your TMDB API Key:
    ```text
    TMDB_API_KEY=insert_your_api_key_here
    ```
3.  Run the following command to generate the obfuscated configuration file:
    ```bash
    flutter pub run build_runner build
    ```

**Note:** For the SSL Pinning feature, certificates are located in `assets/certificates`. Please ensure the certificate is still valid.
