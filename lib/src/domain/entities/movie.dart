class Movie {
  int _voteCount;
  int _id;
  bool _video;
  var _voteAverage;
  String _title;
  double _popularity;
  String _posterPath;
  String _originalLanguage;
  String _originalTitle;
  List<int> _genreIds = [];
  String _backdropPath;
  bool _adult;
  String _overview;
  String _releaseDate;

  Movie(result) {
    _voteCount = result['vote_count'];
    _id = result['id'];
    _video = result['video'];
    _voteAverage = result['vote_average'];
    _title = result['title'];
    _popularity = result['popularity'];
    _posterPath = result['poster_path'];
    _originalLanguage = result['original_language'];
    _originalTitle = result['original_title'];
    for (int i = 0; i < result['genre_ids'].length; i++) {
      _genreIds.add(result['genre_ids'][i]);
    }
    _backdropPath = result['backdrop_path'];
    _adult = result['adult'];
    _overview = result['overview'];
    _releaseDate = result['release_date'];
  }

  String get release_date => _releaseDate;

  String get overview => _overview;

  bool get adult => _adult;

  String get backdrop_path => _backdropPath;

  List<int> get genre_ids => _genreIds;

  String get original_title => _originalTitle;

  String get original_language => _originalLanguage;

  String get poster_path => _posterPath;

  double get popularity => _popularity;

  String get title => _title;

  double get vote_average => _voteAverage;

  bool get video => _video;

  int get id => _id;

  int get vote_count => _voteCount;
}

class Result {
  List<Movie> _moviesList = [];

  Result.fromJson(Map<String, dynamic> parsedJson) {
    print(parsedJson['results'].length);
    List<Movie> temp = [];
    for (int i = 0; i < parsedJson['results'].length; i++) {
      Movie result = Movie(parsedJson['results'][i]);
      temp.add(result);
    }
    _moviesList = temp;
  }

  List<Movie> get moviesList => _moviesList;
}
