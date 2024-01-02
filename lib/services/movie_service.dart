import 'dart:convert';
import 'package:dio/dio.dart';

import '../model/movie.dart';
import '../utils/environment.dart';

class MovieService {
  final dio = Dio();
  final String _dataSource = "Cluster1";
  final String _database = Environment.databaseName;
  final String _collection = Environment.moviesCollection;
  final String _endpoint = Environment.endPointUrl;
  static const _apiKey =
      'Ozp8VH8F6R2jh9tdgQUtZMxwFpSN0iZLNlZ6esGUi20Xd5VrwCsAMiMEgPVCIC7Z';

  var headers = {
    "content-type": "application/json",
    "apiKey": _apiKey,
  };

  Future<List<Movie>> getAllMovies() async {
    try {
      print('_endpoint: $_endpoint');
      var response = await dio.post(
        "$_endpoint/action/find",
        options: Options(headers: headers),
        data: jsonEncode(
          {
            "dataSource": _dataSource,
            "database": _database,
            "collection": _collection,
            "filter": {},
          },
        ),
      );

      if (response.statusCode == 200) {
        var respList = response.data['documents'] as List;
        var movieList = respList.map((json) => Movie.fromJson(json)).toList();
        return movieList;
      } else {
        throw Exception('Error getting movies data');
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<List<Movie>> getMovieByGenre(String genre) async {
    try {
      print('genre: $genre');
      var response = await dio.post(
        "$_endpoint/action/find",
        options: Options(headers: headers),
        data: jsonEncode(
          {
            "dataSource": _dataSource,
            "database": _database,
            "collection": _collection,
            "filter": {"genre": genre},
          },
        ),
      );

      if (response.statusCode == 200) {
        var respList = response.data['documents'] as List;
        var movieList = respList.map((json) => Movie.fromJson(json)).toList();
        return movieList;
      } else {
        throw Exception('Error getting movies data');
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<Movie> getFavoriteMovieById(String id) async {
    print('favoriteIds: $id');
    var response = await dio.post(
      "$_endpoint/action/find",
      options: Options(headers: headers),
      data: jsonEncode(
        {
          "dataSource": _dataSource,
          "database": _database,
          "collection": _collection,
          "filter": {
            "movie_id": {"\$oid": id}
          }
        },
      ),
    );

    if (response.statusCode == 200) {
      var respList = response.data['documents'] as List;
      var movieList = respList.map((json) => Movie.fromJson(json)).toList();
      return movieList[0];
    } else {
      throw Exception('Error getting movies data');
    }
  }

  Future<List<Movie>> fetchMovieListByTag(List<String> tagList) async {
    print('tagList: $tagList');
    var response = await dio.post(
      "$_endpoint/action/find",
      options: Options(headers: headers),
      data: jsonEncode(
        {
          "dataSource": _dataSource,
          "database": _database,
          "collection": _collection,
          "filter": {
            "tags": {"\$in": tagList}
          }
        },
      ),
    );

    if (response.statusCode == 200) {
      var respList = response.data['documents'] as List;
      var movieList = respList.map((json) => Movie.fromJson(json)).toList();

      print('length: ${movieList.length}');
      return movieList;
    } else {
      throw Exception('Error getting movies data');
    }
  }
}
