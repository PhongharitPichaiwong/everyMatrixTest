// ignore_for_file: sdk_version_since
import 'package:flutter/material.dart';

import '../model/movie.dart';
import '../model/movie_preview.dart';
import '../widgets/movie_card.dart';

import 'movie_service.dart';
import 'user_service.dart';

enum MoviePageType {
  All,
  Action,
  Adventure,
  ScienceFiction,
  Drama,
}

class MovieModel {
  Future<List<MovieCard>> getMovies({
    required MoviePageType moviesType,
    required Color themeColor,
  }) async {
    List<MovieCard> temp = [];

    var value = moviesType == MoviePageType.All
        ? await MovieService().getAllMovies()
        : await MovieService().getMovieByGenre(moviesType.name);

    for (var item in value) {
      temp.add(MovieCard(
        moviePreview: MoviePreview(
          isFavorite: false,
          year: (item.dateReleased.toString().length > 4)
              ? item.dateReleased.toString().substring(0, 4)
              : "",
          imageUrl: item.metadataInfo.pictures[0].url,
          title: item.title,
          id: item.movieId,
          rating: 0.0,
          overview: item.description,
        ),
        themeColor: themeColor,
      ));
    }

    return Future.value(temp);
  }

  Future<List<MovieCard>> getFavoriteMovies({
    required Color themeColor,
  }) async {
    List<MovieCard> temp = [];
    List<dynamic> favoritesIds = await UserService()
        .getUserFavoritesIds('609c3bc01c294d15b47c5d8a'); // hardcode for now

    for (var item in favoritesIds) {
      var value = await MovieService().getFavoriteMovieById(item);

      temp.add(MovieCard(
        moviePreview: MoviePreview(
          isFavorite: false,
          year: (value.dateReleased.toString().length > 4)
              ? value.dateReleased.toString().substring(0, 4)
              : "",
          imageUrl: value.metadataInfo.pictures[0].url,
          title: value.title,
          id: value.movieId,
          rating: 0.0,
          overview: value.description,
        ),
        themeColor: themeColor,
      ));
    }

    return Future.value(temp);
  }

  Future<List<MovieCard>> getMoviesByTags({
    required List<String> tagList,
    required Color themeColor,
  }) async {
    List<MovieCard> temp = [];
    List<Movie> movies = await MovieService().fetchMovieListByTag(tagList);

    for (var item in movies) {
      temp.add(MovieCard(
        moviePreview: MoviePreview(
          isFavorite: false,
          year: (item.dateReleased.toString().length > 4)
              ? item.dateReleased.toString().substring(0, 4)
              : "",
          imageUrl: item.metadataInfo.pictures[0].url,
          title: item.title,
          id: item.movieId,
          rating: 0.0,
          overview: item.description,
        ),
        themeColor: themeColor,
      ));
    }

    return Future.value(temp);
  }
}
