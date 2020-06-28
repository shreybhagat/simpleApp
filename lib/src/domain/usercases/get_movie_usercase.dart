import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:simpleApp/src/domain/entities/movie.dart';
import 'package:simpleApp/src/domain/repository/movie_repository.dart';

class GetMovieUseCase
    extends UseCase<GetMovieUseCaseResponse, GetMovieUseCaseParams> {
  final MovieRepository movieRepository;

  GetMovieUseCase(this.movieRepository);

  @override
  Future<Stream<GetMovieUseCaseResponse>> buildUseCaseStream(
      GetMovieUseCaseParams params) async {
    final controller = StreamController<GetMovieUseCaseResponse>();
    try {
      // get user
      final movie = await movieRepository.getMovie(params.apiKey);
      // Adding it triggers the .onNext() in the `Observer`
      // It is usually better to wrap the response inside a response object.
      controller.add(GetMovieUseCaseResponse(movie));
      logger.finest('GetMovieUseCase successful.');
      controller.close();
    } catch (e) {
      logger.severe('GetMovieUseCase unsuccessful.');
      // Trigger .onError
      controller.addError(e);
    }
    return controller.stream;
  }
}

class GetMovieUseCaseParams {
  final String apiKey;

  GetMovieUseCaseParams(this.apiKey);
}

class GetMovieUseCaseResponse {
  final Result movie;

  GetMovieUseCaseResponse(this.movie);
}
