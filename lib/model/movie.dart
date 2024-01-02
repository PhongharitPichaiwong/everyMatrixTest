class Movie {
  String id;
  String title;
  String description;
  String genre;
  List<String> tags;
  int length;
  DateTime dateReleased;
  DateTime dateAvailableUntil;
  MetadataInfo metadataInfo;
  String movieId;
  String thumbnail;

  Movie({
    required this.id,
    required this.title,
    required this.description,
    required this.genre,
    required this.tags,
    required this.length,
    required this.dateReleased,
    required this.dateAvailableUntil,
    required this.metadataInfo,
    required this.movieId,
    required this.thumbnail,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      genre: json['genre'],
      tags: List<String>.from(json['tags']),
      length: int.parse("${json['length']}"),
      dateReleased: DateTime.parse(json['dateReleased']),
      dateAvailableUntil: DateTime.parse(json['dateAvailableUntil']),
      metadataInfo: MetadataInfo.fromJson(json['metadataInfo']),
      movieId: json['movie_id'],
      thumbnail: json['thumbnail'],
    );
  }
}

class MetadataInfo {
  List<Picture> pictures;
  String metaTitle;
  String metaDescription;

  MetadataInfo({
    required this.pictures,
    required this.metaTitle,
    required this.metaDescription,
  });

  factory MetadataInfo.fromJson(Map<String, dynamic> json) {
    return MetadataInfo(
      pictures: List<Picture>.from(
        json['pictures'].map((pic) => Picture.fromJson(pic)),
      ),
      metaTitle: json['metaTitle'],
      metaDescription: json['metaDescription'],
    );
  }
}

class Picture {
  String url;

  Picture({
    required this.url,
  });

  factory Picture.fromJson(Map<String, dynamic> json) {
    return Picture(
      url: json['url'],
    );
  }
}
