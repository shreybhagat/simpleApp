import 'package:simpleApp/src/domain/entities/movie.dart';

abstract class MovieRepository {
  Future<Result> getMovie(String apiKey);
  Future<Result> getTVShows (String apiKey);
}
