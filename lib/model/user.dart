class User {
  String id;
  String userId;
  String username;
  String password;
  String fullname;
  String email;
  String phone;
  List<FavoriteMovie> favoriteMovies;
  Preferences preferences;

  User({
    required this.id,
    required this.userId,
    required this.username,
    required this.password,
    required this.fullname,
    required this.email,
    required this.phone,
    required this.favoriteMovies,
    required this.preferences,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      userId: json['user_id'],
      username: json['username'],
      password: json['password'],
      fullname: json['fullname'],
      email: json['email'],
      phone: json['phone'],
      favoriteMovies: List<FavoriteMovie>.from(
        json['favoriteMovies'].map((movie) => FavoriteMovie.fromJson(movie)),
      ),
      preferences: Preferences.fromJson(json['preferences']),
    );
  }
}

class FavoriteMovie {
  String movieId;
  int rating;

  FavoriteMovie({
    required this.movieId,
    required this.rating,
  });

  factory FavoriteMovie.fromJson(Map<String, dynamic> json) {
    return FavoriteMovie(
      movieId: json['movie_id'],
      rating: int.parse("${json['rating']}"),
    );
  }
}

class Preferences {
  List<String> favoriteCategories;
  String websiteTheme;

  Preferences({
    required this.favoriteCategories,
    required this.websiteTheme,
  });

  factory Preferences.fromJson(Map<String, dynamic> json) {
    return Preferences(
      favoriteCategories: List<String>.from(json['favoriteCategories']),
      websiteTheme: json['websiteTheme'],
    );
  }
}
