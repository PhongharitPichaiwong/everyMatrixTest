import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String get fileName =>
      kReleaseMode ? ".env.production" : ".env.development";
  static String get databaseName => "${dotenv.env['DB_NAME']}";
  static String get moviesCollection => "${dotenv.env['DB_MOVIES_COLLECTION']}";
  static String get usersCollection => "${dotenv.env['DB_USERS_COLLECTION']}";
  static String get endPointUrl => "${dotenv.env['DB_API_ENDPOINT']}";
  String get api => "${dotenv.env['DB_API_KEY']}";
}
