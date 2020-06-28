import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:simpleApp/src/domain/entities/movie.dart';
import 'package:simpleApp/src/domain/repository/movie_repository.dart';

class DataMovieRepository extends MovieRepository {
  static final DataMovieRepository _instance = DataMovieRepository._internal();

  DataMovieRepository._internal();

  Future<Result> fetchMovieList(String apiKey) async {
    print("fetchMovieList called");
    final response = await new Client()
        .get("http://api.themoviedb.org/3/movie/popular?api_key=$apiKey");
    print(response.body.toString());
    if (response.statusCode == 200) {
      return Result.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load movies');
    }
  }

  factory DataMovieRepository() => _instance;

  @override
  Future<Result> getMovie(String apiKey) {
    return fetchMovieList(apiKey);
  }

  @override
  Future<Result> getTVShows(String apiKey) {
    // TODO: not implemented yet, will do once api supports it.
    throw UnimplementedError();
  }
}
