import 'dart:convert';
import 'package:dio/dio.dart';

import '../model/user.dart';
import '../utils/environment.dart';

class UserService {
  final dio = Dio();
  final String _dataSource = "Cluster1";
  final String _database = Environment.databaseName;
  final String _collection = Environment.usersCollection;
  final String _endpoint = Environment.endPointUrl;
  static const _apiKey =
      'Ozp8VH8F6R2jh9tdgQUtZMxwFpSN0iZLNlZ6esGUi20Xd5VrwCsAMiMEgPVCIC7Z';

  var headers = {
    "content-type": "application/json",
    "apiKey": _apiKey,
  };

  Future<List<dynamic>> getUserFavoritesIds(String id) async {
    try {
      var temp = [];
      print('_endpoint: $_endpoint');
      var response = await dio.post(
        "$_endpoint/action/find",
        options: Options(headers: headers),
        data: jsonEncode(
          {
            "dataSource": _dataSource,
            "database": _database,
            "collection": _collection,
            "filter": {
              "user_id": {"\$oid": id}
            },
          },
        ),
      );

      if (response.statusCode == 200) {
        var respList = response.data['documents'] as List;
        var user = respList.map((json) => User.fromJson(json)).toList();

        for (var element in user[0].favoriteMovies) {
          temp.add(element.movieId);
        }

        return Future.value(temp);
      } else {
        throw Exception('Error getting movies data');
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
